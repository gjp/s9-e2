module Colony
  class Tile
    include MagicNumbers

    attr_reader :owner, :neighbors

    def initialize
      @owner = NEUTRAL
      @hive = false
      @resource = false
      @sentry = nil
      @players = []
      @neighbors = {}
    end

    def connect(direction, tile)
      @neighbors[direction] = tile
    end

    def neighbor(direction)
      @neighbors[direction]
    end

    def to_s
      # FIXME: Having multiple overlapping items in a tile is currently a problem.
      # Need color or graphics, otherwise players obscure what they're standing on,
      # including each other :(
      
      if @players.size > 0
        @players[0]
      elsif @hive
        GLYPHS[:hive]
      elsif @resource
        @owner == FRIENDLY ? GLYPHS[:friendly_node] : GLYPHS[:neutral_node]
      elsif @sentry
        GLYPHS[:sentry]
      elsif @owner == FRIENDLY
        GLYPHS[:friendly]
      elsif @owner == ENEMY
        GLYPHS[:enemy]
      else
        GLYPHS[:empty]
      end
    end

    def build_friendly_hive
      @hive = true
      @owner = FRIENDLY
    end

    def build_enemy_hive
      @hive = true
      @owner = ENEMY
    end

    def add_player(player)
      @players << player
    end

    def remove_player(player)
      @players.delete(player)
    end

    def empty?
      !@hive && !@resource && !@sentry && @players.size == 0
    end

    def build_resource
      @resource = true
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
