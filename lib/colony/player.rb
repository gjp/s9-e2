module Colony
  class Player

    attr_reader :id, :hp, :food, :movement, :tile

    include MagicNumbers
    include HighLine::SystemExtensions

    def initialize(map, id)
      @map = map
      @id = id
      reset
    end

    def reset
      heal
      reset_movement
      remove_food
      @hand = []
      @tile = move_to(@map.friendly_hive) if @map
    end

    def reset_movement
      @movement = PLAYER_MOVEMENT
    end

    def heal
      @hp = PLAYER_HP
    end

    def start_turn
      reset if dead?
      draw_cards # TODO
      reset_movement
    end

    def move_to(tile)
      @tile.remove_player(self) if @tile
      tile.add_player(self)
      @tile = tile
    end

    def move(direction)
      return false unless @movement > 0

      if t = @tile.neighbor(direction)
        move_to(t)

        if t.pwned?
          adjust_movement(-2)
          adjust_hp(-1)
        else
          t.friendly
          adjust_movement(-1)
        end

      end
    end

    def gather
      if @tile.resource? && @food < PLAYER_FOOD_CAP
        @food = PLAYER_FOOD_CAP
        # FIXME Possibly a rule change because this is so annoying
        # @movement = 0
      end
    end

    def attract_sentry
      return unless (@food >= SENTRY_FOOD_COST) && @tile.can_build_sentry?
      @tile.build_sentry
      adjust_food(-SENTRY_FOOD_COST)
    end

    def dead?
      @hp <= 0
    end

    def mobile?
      @movement > 0
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

    def adjust_movement(move)
      [@movement += move, 0].max
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
        o.adjust_movement(4)
      end,
    scavenge: Card.new(
      'All-you-can-eat buffet!') {|o| o.adjust_food(2) }
    }

  end
end
