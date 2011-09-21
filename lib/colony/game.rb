module Colony
  class Game
    attr_reader :map, :players, :team_resources, :turn

    include MagicNumbers

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
      @enemy = Enemy.new
      @team_resources = 0
      @turn = 0
      @game_over = false
    end

    def prompt
      puts "\nColony - a console game about giant bugs. How many players?"
      players = gets.to_i
      players.times { |i| add_player(i) }

      game_loop
    end

    def add_player(i)
      @players << Player.new(i)
    end

    def game_loop
      until @game_over
        @players.each do |player|
          puts @map.to_s
          player.turn
          win && break if win?
        end

        @enemy.turn
        lose && break if lose?
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
      true 
    end

    def game_over?
      win? or lose?
    end

  end
end
