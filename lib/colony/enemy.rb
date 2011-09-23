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
      choices = @map.ripe_for_conquest
      player_engulfed = false 

      # FIXME If we're attacking a sentry, try to finish it off first.
      
      while movement > 0 
        tile = choices.sample
        choices.delete(tile)

        tile.friendly? ? movement -= 2 : movement -= 1
        tile.pwn

        if tile.resource?
          increase_expansion(ENEMY_CAPTURE_BONUS)
          movement += ENEMY_CAPTURE_BONUS
        end

        tile.neighbors.each_value { |n| choices << n unless n.pwned? }
      end

      increase_expansion(ENEMY_ACCELERATION)
    end
    
  end
end
