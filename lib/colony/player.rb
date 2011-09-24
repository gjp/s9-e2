module Colony
  class Player

    attr_reader :id, :hp, :food, :moves, :tile

    include MagicNumbers
    include HighLine::SystemExtensions

    def initialize(map, id, num_players)
      @map = map
      @id = id
      @food_cap = PLAYER_FOOD_CAP / num_players
      reset
    end

    def reset
      reset_hp
      reset_moves
      remove_food
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
          adjust_moves(-2)
          adjust_hp(-1)
        else
          t.friendly
          adjust_moves(-1)
        end

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
      adjust_moves(-1)
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

    def remove_food
      f, @food = @food, 0
      f
    end

    def adjust_hp(hp)
      @hp += hp
    end

    def adjust_food(food)
      [@food += food, 0].max
    end

    def adjust_moves(move)
      [@moves += move, 0].max
    end

    def add_card(card)
      @hand << card
    end

    def remove_card(card)
      @hand.delete(card)
    end

    def draw_cards
      #FIXME
    end

    def play_card(card)
      PLAYER_CARDS[card].play(self)
    end

    PLAYER_CARDS = {
      sentry: Card.new(
      'My, what big mandibles you have') {},
       speed: Card.new(
      'It is by caffeine alone I set my mind in motion') do |o|
        o.adjust_moves(4)
      end,
    scavenge: Card.new(
      'All-you-can-eat buffet!') {|o| o.adjust_food(2) }
    }

  end
end
