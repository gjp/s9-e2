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

    def to_s
      # yuck. perhaps I'll have time to make a nice interface with curses
      
      hr = '+' + '-' * MAP_COLS + "+\n"
      out = '' + hr
      @tiles.each_with_index do |row, r|
        out << '|' + row.map { |col| col.to_s }.join + "|\n"
      end
      out << hr
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
      #FIXME: This needs a zoned algorithm to be somewhat fair
      # for now it's just random
      
      nodes = 0
      until nodes == RESOURCE_NODE_COUNT do
        r = rand(MAP_ROWS)
        c = rand(MAP_COLS)

        next unless @tiles[r][c].empty?

        build_resource(r, c)
        nodes += 1
      end
    end

    def build_resource(row, col)
      @tiles[row][col].build_resource
    end

    def move_player(player, from, to)
      #FIXME important!!
    end

    def friendly_tiles
      @tiles.flatten.select{|t| t.friendly?}
    end

    def enemy_tiles
      @tiles.flatten.select{|t| t.enemy?}
    end

    def hive_tiles
      @tiles.flatten.select{|t| t.hive?}
    end

    def resource_tiles
      @tiles.flatten.select{|t| t.resource?}
    end
  end
end
