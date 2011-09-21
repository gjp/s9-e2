module Colony
  class Player

    attr_accessor :hp, :food, :movement

    def initialize
      @hp = 0
      @food = 0
      @movement = 0
      @hand = []
    end

    def add_hp(hp)
      @hp += hp
    end

    def subtract_hp(hp)
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
