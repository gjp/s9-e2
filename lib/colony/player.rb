module Colony
  class Player

    attr_accessor :id, :hp, :food, :movement

    include MagicNumbers
    include HighLine::SystemExtensions

    def initialize(game, id)
      @game = game #hrrrrm.
      @id = id
      reset
    end

    def reset
      @hp = PLAYER_HP
      @food = 0
      @movement = PLAYER_MOVEMENT
      @hand = []
      # move player to start
    end

    def start_turn(game)
      reset if @hp <= 0
      draw_cards #stub
      @movement = PLAYER_MOVEMENT
    end

    def draw_cards
    end

    def add_hp(hp)
      @hp += hp
    end

    def subtract_hp(hp)
      #FIXME if dead, temporarily remove player from map
      @hp -= hp
    end

    def add_food(food)
      @food += food 
    end

    def subtract_food(food)
      @food -= food 
    end

    def add_movement(move)
      @movement += move
    end

    def subtract_movement(move)
      @movement -= move
    end

    def add_card(card)
      @hand << card
    end

    def remove_card(card)
      @hand.delete(card)
    end

    def play_card(card)
      PLAYER_CARDS[card].play(self)
    end

    PLAYER_CARDS = {
      sentry: Card.new(
      'My, what big mandibles you have') {},
       speed: Card.new(
      'It is by caffeine alone I set my mind in motion.') {|o| o.add_movement(2) },
    scavenge: Card.new(
      'All you can eat buffet') {|o| o.add_food(2) }
    }

  end

end
