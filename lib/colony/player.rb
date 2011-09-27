module Colony
  class Player
    include MagicNumbers

    attr_reader :id, :hp, :food, :moves, :hand, :tile

    def initialize(args)
      args.each { |k,v| instance_variable_set('@'+k.to_s, v) }
      @food_cap = PLAYER_FOOD_CAP / @num_players
      reset
    end

    def reset
      reset_hp
      reset_moves
      remove_food
      @hand = []
      @immunity = false
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
      @tile.resource? && (@food < @food_cap)
    end

    def gather
      return nil unless can_gather?
      @food = @food_cap
      adjust_moves(-1)
    end

    def can_build_sentry?
      ( SENTRY_FOOD_COST <= @food ) && @tile.can_build_sentry?
    end

    def attract_sentry
      return nil unless can_build_sentry?
      @tile.build_sentry
      adjust_food(-SENTRY_FOOD_COST)
    end

    def turn_ended?
      dead? || !mobile?
    end

    def dead?
      @hp <= 0
    end

    def mobile?
      @moves > 0
    end

    def immune
      @immunity = true
    end

    def immune?
      @immunity
    end

    def end_turn
      @immunity = false
    end

    def remove_food
      f, @food = @food, 0
      f
    end

    def adjust_hp(hp)
      @hp += hp
    end

    def adjust_food(food)
      @food = [ [@food += food, 0].max, @food_cap].min
    end

    def adjust_moves(move)
      @moves = [@moves += move, 0].max
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
