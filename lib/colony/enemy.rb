module Colony
  class Enemy

    include MagicNumbers

    def initialize(game)
      @game = game #hrrrrm.
      @sentry = nil
      @expansion = ENEMY_BASE_EXPANSION
    end

    def turn(game)
      expand_territory
    end

    def increase_expansion(i)
      @expansion += i
    end

    # FIXME factor this
    def expand_territory
      puts "Expanding enemy territory..."
      movement = @expansion
      choices_choices = @game.map.ripe_for_conquest

      # FIXME If we're attacking a sentry, try to finish it off first.
      
      while movement > 0 
        t = choices_choices.sample
        t.friendly? ? movement -= 2 : movement -= 1
        t.enemy

        @game.lose if t.hive?

        if t.resource?
          increase_expansion(ENEMY_CAPTURE_BONUS)
          movement += ENEMY_CAPTURE_BONUS
        end

        t.neighbors.each_value { |n| choices_choices << n unless n.enemy? }
      end

      increase_expansion(ENEMY_ACCELERATION)
    end
    
  end
end
