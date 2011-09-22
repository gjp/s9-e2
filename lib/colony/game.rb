module Colony
  class Game
    attr_reader :map, :players, :team_resources, :round

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
      @enemy = Enemy.new(@map)
      @players = []

      @team_resources = 0
      @round = 0
      @game_over = false

      @hl = HighLine.new
    end

    def prompt
      puts "Colony - a console game about giant bugs."
      #players = gets.to_i
      players = 2
      1.upto(players) { |i| add_player(i) }

      game_loop
    end

    def add_player(i)
      player = Player.new(@map, i)
      @players << player
    end

    def game_loop
      until @game_over
        @round += 1
        @players.each do |player|
          player.start_turn
          input_for(player)
          win && break if win?
        end

        gather_resources
        win if win?

        lose if @enemy.turn
      end
    end 

    def update_display(player)
      puts
      puts @map.to_s

      puts "Round #{@round}: Your hive has #{@team_resources} food."
      puts "Player #{player.id}: You have #{player.hp} HP, #{player.food} food,"\
           " and #{player.movement} movement"
      # FIXME only display available moves
      puts "WASD to move, 1 or 2 to play a card"
    end

    def input_for(player)
      turn_over = false

      until turn_over
        update_display(player)

        k = get_character

        case k.chr
        when 'w'
          player.move(:up)
        when 'a'
          player.move(:left)
        when 's'
          player.move(:down)
        when 'd'
          player.move(:right)
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

    def gather_resources
      c = @map.friendly_resource_tiles.count
      @team_resources += c * RESOURCES_GATHERED_PER_ROUND
    end

  end
end
