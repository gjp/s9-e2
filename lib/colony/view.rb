module Colony
  class View
    include MagicNumbers
    include HighLine::SystemExtensions

    def initialize(game)
      @game = game
      # May require screen init if using Curses
    end

    def prompt_for_players
      say '*** Colony - a console game about giant bugs. ***'
      ask("Number of players? (2-4) ", Integer) { |q| q.in = 1..4 }
    end

    def update_display(player)
      say @game.map.to_s

      show_status(player)
      show_options(player)
    end

    def show_status(player)
      say "Round #{@game.round}: "
      say "Your hive has #{@game.hive_food} food."

      say "Player #{player.id}: You have #{player.hp} HP, "
      say "#{player.food} food, and #{player.moves} moves"
    end

    def show_options(player)
      o = []
      o << "wasd to move" if player.mobile?
      o << "g to gather" if player.can_gather?

      unless player.hand.empty?
        card_desc = []
        player.hand.each_with_index do |c, i|
          card_desc << "(#{i + 1}) #{c.name}"
        end
        o << "or play cards: " + card_desc.join(' ')
      end

      say o.join(', ')
    end

    def input_for(player)
      update_display(player)

      k = get_character

      # TODO end turn, discard
      case k.chr
      when 'w' then player.move(:up)
      when 'a' then player.move(:left)
      when 's' then player.move(:down)
      when 'd' then player.move(:right)
      when 'g' then player.gather
      when '1' then player.play_card(player.hand[0])
      when '2' then player.play_card(player.hand[1])
      else puts 'invalid move'
      end
    end

    def show_end_message(status)
      say @game.map.to_s
      say ( status == :win ? MESSAGE_WIN : MESSAGE_LOSE )
    end
  end
end
