module Colony
  class Map

    include MagicNumbers

    attr_reader :tiles

    def initialize
      @tiles = Array.new(MAP_ROWS) {
               Array.new(MAP_COLS) {Tile.new} }
      place_hives
      place_resources
    end

    def width
      @tiles[0].size
    end

    def height
      @tiles.size
    end

    def place_hives
      @tiles[0][0].build_friendly_hive
      @tiles[MAP_ROWS-1][MAP_COLS-1].build_enemy_hive
    end

    def place_resources
    end

    def move_player(from, to)
    end

    def player_tiles
    end

    def enemy_tiles
    end
  end
end
