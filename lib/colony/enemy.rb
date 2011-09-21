module Colony
  class Enemy

    include MagicNumbers

    def initialize
      @sentry = nil
      @expansion_rate = ENEMY_EXPANSION_RATE
    end

    def turn
      puts "Enemy turn."
    end

    def increase_expansion_rate

    end

    def expand_territory(map)
    end
    
  end
end
