module Colony
  class Game
    attr_reader :map, :players, :team_resources, :round

    include MagicNumbers

    def self.run
      game = new
      game.greet
    end

    def initialize
      @view = View.new(self)
      @map = Map.new
      @enemy = Enemy.new(@map)

      @team_resources = 0
      @round = 0
      @game_over = false
    end

    def greet
      @num_players = @view.prompt_for_players
      1.upto(@num_players) { |i| add_player(i) }

      game_loop
    end

    def add_player(i)
      @players ||= []
      @players << Player.new(@map, i, @num_players)
    end

    def game_loop
      trap('SIGINT') { force_quit }

      until @game_over do
        @round += 1

        catch(:win_by_player) do
          @players.each do |player|
            player.start_turn

            until player.turn_ended?
              @view.input_for(player)
              deposit_resources
              throw(:win_by_player) if win?
            end
          end
        end

        gather_resources
        end_game(:win) if win?

        @enemy.grow_territory
        end_game(:lose) if lose?
      end
    end

    def end_game(status)
      @game_over = true
      @view.show_end_message(status)
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

    def deposit_resources
      @map.friendly_hive.players.each do |p|
        p.reset_hp
        @team_resources += p.remove_food
      end
    end

    def force_quit
      puts "Quitter! :p"
      exit
    end

  end
end
