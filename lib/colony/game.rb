module Colony
  class Game
    include MagicNumbers

    attr_reader :map, :players, :hive_food, :food_to_win, :round

    def self.run
      game = new
      game.greet
    end

    def initialize
      @view      = View.new(self)
      @map       = Map.new
      @enemy     = Enemy.new(@map)
      @deck      = Deck.new
      @discard   = []

      @hive_food = 0
      @round     = 0
      @game_over = false
    end

    def greet
      @num_players = @view.prompt_for_players
      @food_to_win = FOOD_REQUIRED_PER_PLAYER * @num_players

      1.upto(@num_players) { |i| add_player(i) }

      game_loop
    end

    def add_player(i)
      @players ||= []
      @players << Player.new(
        id: i,
        map: @map,
        deck: @deck,
        discard: @discard
      )
    end

    def game_loop
      trap('SIGINT') { force_quit }

      until @game_over do
        @round += 1

        catch(:win_by_player) do
          @players.each do |player|
            player.start_turn

            until player.turn_ended?
              @view.update_display(player)
              @view.input_for(player)
              turn_bookkeeping
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
      exit
    end
 
    def win?
      @hive_food >= FOOD_REQUIRED_PER_PLAYER * @num_players
    end

    def lose?
      !@map.friendly_hive
    end

    def gather_resources
      c = @map.friendly_resource_tiles.count
      @hive_food += c * FOOD_GATHERED_PER_ROUND
    end

    def turn_bookkeeping
      deposit_resources
      recycle_discard
    end

    def deposit_resources
      @map.friendly_hive.players.each do |p|
        p.reset_hp
        @hive_food += p.remove_food
      end
    end

    def recycle_discard
      return if @deck.size >= PLAYER_HAND_SIZE
      @deck.insert(@discard)
      @deck.shuffle
    end

    def force_quit
      puts "Quitter! :p"
      exit
    end

  end
end
