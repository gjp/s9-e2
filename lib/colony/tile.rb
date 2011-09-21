module Colony
  class Tile
    include MagicNumbers

    attr_reader :owner

    def initialize
      @owner = NEUTRAL
      @hive = false
      @resource = false
      @sentry = nil
      @players = []
    end

    def neutral?
      @owner == NEUTRAL
    end

    def friendly?
      @owner == FRIENDLY
    end

    def enemy?
      @owner == ENEMY
    end

    def build_friendly_hive
      @hive = true
      @owner = FRIENDLY
    end

    def build_enemy_hive
      @hive = true
      @owner = ENEMY
    end

    def build_resource
      @resource = true
    end

    def hive?
      @hive
    end

    def resource?
      @resource
    end

    def sentry?
      !!@sentry
    end
    
  end
end
