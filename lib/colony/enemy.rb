module Colony
  class Enemy

    include MagicNumbers

    def initialize(map)
      @map = map
      @sentry = nil
      @expansion = ENEMY_BASE_EXPANSION
    end

    def turn
      expand_territory
    end

    def increase_expansion(i)
      @expansion += i
    end

    # FIXME factor this
    def expand_territory
      puts "Expanding enemy territory..."
      movement = @expansion
      choices_choices = @map.ripe_for_conquest
      player_engulfed = false 

      # FIXME If we're attacking a sentry, try to finish it off first.
      
      while movement > 0 
        t = choices_choices.sample
        t.friendly? ? movement -= 2 : movement -= 1
        t.enemy

        player_engulfed = true if t.hive?

        if t.resource?
          increase_expansion(ENEMY_CAPTURE_BONUS)
          movement += ENEMY_CAPTURE_BONUS
        end

        t.neighbors.each_value { |n| choices_choices << n unless n.enemy? }
      end

      increase_expansion(ENEMY_ACCELERATION)

      player_engulfed
    end
    
  end
end
