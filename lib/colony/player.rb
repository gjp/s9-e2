module Colony
  class Player
    include MagicNumbers

    attr_reader :id, :hp, :food, :moves, :hand, :tile

    def initialize(params)
      @id      = params[:id]
      @map     = params[:map]
      @deck    = params[:deck]
      @discard = params[:discard]

      reset
    end

    def reset
      reset_hp
      reset_moves
      remove_food
      remove_immunity
      @hand = []
      @tile = move_to(@map.friendly_hive) if @map
    end

    def reset_moves
      @moves = PLAYER_MOVES
    end

    def reset_hp
      @hp = PLAYER_HP
    end

    def start_turn
      reset if dead?
      remove_immunity
      draw_cards
      reset_moves
    end

    def move_to(tile)
      @tile.remove_player(self) if @tile
      tile.add_player(self)
      @tile = tile
    end

    def move(direction)
      return false unless @moves > 0

      if t = @tile.neighbor(direction)
        move_to(t)

        if t.pwned?
          unless immune?
            adjust_moves(-1)
            adjust_hp(-1)
          end
        elsif t.neutral?
          t.friendly
        end

        adjust_moves(-1)
      end
    end

    def can_gather?
      @tile.resource? && (@food < PLAYER_FOOD_CAP)
    end

    def gather
      return nil unless can_gather?
      @food = PLAYER_FOOD_CAP
      adjust_moves(-1)
    end

    def can_attract_sentry?
      ( SENTRY_FOOD_COST <= @food ) && @tile.can_attract_sentry?
    end

    def attract_sentry
      return nil unless can_attract_sentry?
      @tile.attract_sentry
      adjust_food(-SENTRY_FOOD_COST)
    end

    def end_turn
      @moves = 0
    end

    def turn_ended?
      dead? || !mobile?
    end

    def dead?
      @hp <= 0
    end

    def adjust_hp(hp)
      @hp += hp
    end

    def mobile?
      @moves > 0
    end

    def adjust_moves(move)
      @moves = [@moves += move, 0].max
    end

    def immune?
      @immunity
    end

    def immune
      @immunity = true
    end

    def remove_immunity
      @immunity = false
    end

    def remove_food
      f, @food = @food, 0
      f
    end

    def adjust_food(food)
      @food = [ [@food += food, 0].max, PLAYER_FOOD_CAP].min
    end

    def add_card(card)
      @hand << card
    end

    def remove_card(card)
      @hand.delete_at( @hand.index(card) )
    end

    def draw_cards
      until @hand.size == PLAYER_HAND_SIZE do
        @hand << @deck.draw
      end
    end

    def play_card(card)
      return nil unless card
      if card.play(self)
        @discard << remove_card(card)
        adjust_moves(-1)
      end
    end

  end
end
