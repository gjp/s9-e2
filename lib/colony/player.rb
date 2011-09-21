module Colony
  class Player

    attr_accessor :hp, :food, :movement

    include MagicNumbers

    def initialize(id)
      @id = id
      @hp = PLAYER_HP
      @food = 0
      @movement = 0
      @hand = []
    end

    def turn
      #FIXME important!!
      p "Player #{@id} turn."
      @movement = PLAYER_MOVEMENT
      respond_to_input
    end

    def respond_to_input
      puts "Input loop goes here."
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
