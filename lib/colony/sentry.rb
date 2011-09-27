module Colony
  class Sentry
    include MagicNumbers

    def initialize(tile)
      @tile = tile
      @hp = SENTRY_HP
    end

    def damage(hp)
      die if hp >= @hp
      hp - @hp
    end

    def die
      @tile.remove_sentry
    end
    
  end
end
