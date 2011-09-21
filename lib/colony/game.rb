module Colony
  class Game
    attr_reader :map, :players, :team_resources, :turn

    include MagicNumbers
    include HighLine::SystemExtensions

    def self.run(argv)
      #FIXME argv ignored
      loop do
        game = new
        game.prompt
      end
    end

    def initialize
      @map = Map.new
      @players = []
      @enemy = Enemy.new(self)
      @team_resources = 0
      @turn = 0
      @game_over = false
      @hl = HighLine.new
    end

    def prompt
      puts "Colony - a console game about giant bugs."
      #players = gets.to_i
      players = 2
      players.times { |i| add_player(i) }

      game_loop
    end

    def add_player(i)
      @players << Player.new(self, i)
    end

    def game_loop
      until @game_over
        @players.each do |player|
          #puts @map.to_s
          player.start_turn(self)
          respond_to_input(player)
          win && break if win?
        end

        @enemy.turn(self)
        lose && break if lose?
      end
    end 

    def respond_to_input(player)
      turn_over = false

      until turn_over
        puts
        puts @map.to_s

        puts "Player #{player.id}: You have #{player.hp} HP, #{player.food} food,"\
             " and #{player.movement} movement"
        puts "WASD to move, 1 or 2 to play a card"

        k = get_character

        #FIXME: copypasta for quick keyboard test
        case k.chr
        when 'w'
          puts 'move up'
          player.subtract_movement(1)
        when 'a'
          puts 'move left'
          player.subtract_movement(1)
        when 's'
          puts 'move down'
          player.subtract_movement(1)
        when 'd'
          puts 'move right'
          player.subtract_movement(1)
        when '1'
          puts 'play card 1'
        when '2'
          puts 'play card 2'
        else
          puts 'invalid move'
        end

        turn_over = true if player.movement <= 0
      end
    end

    def win
      puts "You win!"
      @game_over = true
    end

    def lose
      puts "You lose!"
      @game_over = true
    end
 
    def win?
      @team_resources >= WINNING_RESOURCE_COUNT
      false
    end

    def lose?
      # FIXME
      # @map.friendly_hive.engulfed?
      # @map.enemy_resource_nodes.count = RESOURCE_NODE_COUNT
      false
    end

    def game_over?
      win? or lose?
    end

  end
end
