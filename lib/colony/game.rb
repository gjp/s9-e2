module Colony
  class Game
    attr_reader :map, :players, :team_resources, :round

    include MagicNumbers
    include HighLine::SystemExtensions

    def self.run(argv)
      #FIXME argv ignored
      game = new
      game.prompt
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
      catch :game_over do
        loop do
          @round += 1

          @players.each do |player|
            player.start_turn
            input_for(player)
            end_game(:win) if win?
          end

          gather_resources
          end_game(:win) if win?

          @enemy.grow_territory
          end_game(:lose) if lose?
        end
      end
    end 

    def update_display(player)
      puts; puts @map.to_s
      puts "Round #{@round}: Your hive has #{@team_resources} food."
      puts "Player #{player.id}: You have #{player.hp} HP,"\
           " #{player.food} food, and #{player.movement} movement"
      # FIXME only display available moves
      puts "WASD to move, 1 or 2 to play a card"
    end

    def input_for(player)
      until turn_over?(player)
        update_display(player)

        k = get_character

        # TODO end turn, end game, trade?
        case k.chr
        when 'w' then player.move(:up)
        when 'a' then player.move(:left)
        when 's' then player.move(:down)
        when 'd' then player.move(:right)
        when 'g' then player.gather
        when '1' then player.attract_sentry
        when '2' then puts 'play card 2'
        else puts 'invalid move'
        end

        @map.friendly_hive.players.each do |p|
          p.heal
          @team_resources += p.remove_food
        end
      end
    end

    def turn_over?(player)
      player.dead? || !player.mobile?
    end

    def end_game(status)
      puts @map.to_s
      if status == :win
        puts "Your queen has matured! There she goes, off into the sunset."
      else
        puts "Your hive has been overrun. Everybody dies...even the queen."
      end
      throw :game_over
    end
 
    def win?
      @team_resources >= WINNING_RESOURCE_COUNT
    end

    def lose?
      !@map.friendly_hive
    end

    def gather_resources
      c = @map.friendly_resource_tiles.count
      @team_resources += c * RESOURCES_GATHERED_PER_ROUND
    end

  end
end
