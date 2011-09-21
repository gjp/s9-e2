module Colony
  class Enemy

    include MagicNumbers

    def initialize(game)
      @game = game #hrrrrm.
      @sentry = nil
      @expansion_rate = ENEMY_EXPANSION_RATE
    end

    def turn(game)
      puts "\nEnemy turn."
      expand_territory
      increase_expansion_rate
    end

    def increase_expansion_rate
      @expansion_rate += ENEMY_EXPANSION_FACTOR
      puts "Expansion rate is now #{@expansion_rate}"
    end

    def expand_territory
      puts "Pretend we're expanding territory..."
      movement = @expansion_rate
      # This'll be fun.
      #
      # If we're attacking a sentry, try to finish it off first.
      # This absorbs movement points.
      #
      # Obtain a list of all enemy tiles which have at least one neighboring tile
      # which is not an enemy tile. Sort by number of open neighbors, ascending.
      # This prefers filling internal gaps to sending out random shoots.
      #
      # Pick the first tile on the list and grow in random directions until we're
      # wedged in or out of movement points.
      #
      # If points remain, pick the next tile off the stack and repeat.
    end
    
  end
end
