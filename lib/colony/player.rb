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
      @tile = move_to(@game.map.friendly_hive) if @game
    end

    def move_to(tile)
      @tile.remove_player(@id) if @tile
      tile.add_player(@id)
      @tile = tile
    end

    def move(direction)
      return false unless @movement > 0

      if t = @tile.neighbor(direction)
        move_to(t)

        if t.enemy?
          adjust_movement(-2)
          adjust_hp(-1)
        else
          t.friendly
          adjust_movement(-1)
        end
      end
    end

    def start_turn
      puts "\n***** Player #{@id}'s turn begins *****"
      reset if @hp <= 0
      draw_cards #stub
      @movement = PLAYER_MOVEMENT
    end

    def draw_cards
      #FIXME
    end

    def adjust_hp(hp)
      @hp += hp
      if @hp <= 0
        puts "*** Oh noes! You have died! You'll respawn at the hive next round. ***"
        @tile.remove_player(@id)
      end
      @hp
    end

    def adjust_food(food)
      @food += food 
      @food = 0 if @food < 0
      @food
    end

    def adjust_movement(move)
      @movement += move
      @movement = 0 if @movement < 0
      @movement
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
      'It is by caffeine alone I set my mind in motion.') {|o| o.adjust_movement(2) },
    scavenge: Card.new(
      'All-you-can-eat buffet') {|o| o.adjust_food(2) }
    }

  end
end
