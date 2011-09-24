module Colony
  class View
    include MagicNumbers
    include HighLine::SystemExtensions

    def initialize(game)
      @game = game
      # May require screen init if using Curses
    end

    def prompt_for_players
      say "Colony - a console game about giant bugs."
      ask("Number of players? (2-4) ", Integer) { |q| q.in = 1..4 }
    end

    def update_display(player)
      say @game.map.to_s

      show_status
      show_options
    end

    def show_status(player)
      say "Round #{@game.round}: "
      say "Your hive has #{@game.team_resources} food."

      say "Player #{player.id}: You have #{player.hp} HP, "
      say "#{player.food} food, and #{player.moves} moves"
    end

    def show_options(player)
      o = []
      o << "WASD to move" if player.mobile?
      o << "g to gather" if player.can_gather?
      o << "1 to attract a Sentry" if player.tile.can_build_sentry?
      say o.join(', ')
    end

    def input_for(player)
      update_display(player)

      k = get_character

      # TODO end turn?
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
    end

    def show_end_message(status)
      say @game.map.to_s
      say ( status == :win ? MESSAGE_WIN : MESSAGE_LOSE )
    end
  end
end
