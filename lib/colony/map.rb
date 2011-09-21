module Colony
  class Map

    include MagicNumbers

    attr_reader :tiles

    def initialize
      @tiles = Array.new(MAP_ROWS) {
               Array.new(MAP_COLS) {Tile.new} }
      build_hives
      choose_resource_locations
    end

    def width
      @tiles[0].size
    end

    def height
      @tiles.size
    end

    def build_hives
      @tiles[0][0].build_friendly_hive
      @tiles[MAP_ROWS-1][MAP_COLS-1].build_enemy_hive
    end

    def choose_resource_locations
    end

    def build_resource(row, col)
      @tiles[row][col].build_resource
    end

    def move_player(player, from, to)
      #FIXME important!!
       
    end

    def player_tiles
    end

    def enemy_tiles
    end

    def hive_tiles
    end

    def resource_tiles
    end

    def enemy_resource_tiles
    end
  end
end
