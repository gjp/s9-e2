module Colony
  class Tile
    include MagicNumbers

    attr_reader :owner, :neighbors, :players
    attr_accessor :sentry

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
      # FIXME: Having multiple overlapping items in a tile is currently
      # a problem. We need color or graphics, otherwise players obscure
      # what they're standing on, including each other :(
      
      if @players.size > 0
        @players[0].id
      elsif hive?
        GLYPHS[:hive]
      elsif resource?
        friendly? ? GLYPHS[:friendly_node] : GLYPHS[:neutral_node]
      elsif sentry?
        GLYPHS[:sentry]
      elsif friendly?
        GLYPHS[:friendly]
      elsif pwned?
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

    def add_player(p)
      @players << p
    end

    def remove_player(p)
      @players.delete(p)
    end

    def remove_sentry
      @sentry = nil
    end

    def empty?
      !@hive && !@resource && !@sentry && @players.size == 0
    end

    def can_attract_sentry?
      !@hive && !@resource && !@sentry && friendly?
    end

    def build_resource
      @resource = true
    end

    def attract_sentry
      return nil unless can_attract_sentry?
      @sentry = Sentry.new(self)
    end

    def neutral?
      @owner == NEUTRAL
    end

    def friendly?
      @owner == FRIENDLY
    end

    def friendly
      @owner = FRIENDLY
    end

    def pwned?
      @owner == ENEMY
    end

    def pwn
      @owner = ENEMY
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
