module Colony
  class Map
    include MagicNumbers

    attr_reader :tiles

    def initialize
      create_tiles
      connect_tiles
      build_hives
      build_resources
    end

    def create_tiles
      @tiles = Array.new(MAP_ROWS) {
               Array.new(MAP_COLS) {Tile.new} }
    end

    def connect_tiles
      @tiles.each_with_index do |row, r|
        row.each_with_index do |tile, c|
          tile.connect( :left,  @tiles[r][c-1] ) if c-1 >= 0
          tile.connect( :right, @tiles[r][c+1] ) if c+1 < MAP_COLS
          tile.connect( :up,    @tiles[r-1][c] ) if r-1 >= 0
          tile.connect( :down,  @tiles[r+1][c] ) if r+1 < MAP_ROWS
        end
      end
    end

    def build_hives
      @tiles[0][0].build_friendly_hive
      @tiles[MAP_ROWS-1][MAP_COLS-1].build_enemy_hive
    end

    # Completely random starting maps have too much influence on the game.
    # This algorithm places the resource nodes at incrementally increasing
    # distances from the starting hive in attempt to even things out.

    def build_resources
      delta = (MAP_ROWS + MAP_COLS) / (RESOURCE_NODE_COUNT + 1)
      distance = delta 
      nodes = 0
      
      until nodes == RESOURCE_NODE_COUNT do
        r = rand( [MAP_ROWS, distance].min )
        c = distance - r

        next if c >= MAP_COLS or !@tiles[r][c].empty?

        @tiles[r][c].build_resource
        distance += delta
        nodes += 1
      end
    end

    def to_s
      # yuck. perhaps I'll have time to make a nice interface with curses
      hr = '+' + '-' * MAP_COLS * 2 + "+\n"
      out = hr.dup

      @tiles.each do |row|
        out << '|' + row.map { |col| "#{col.to_s} " }.join + "|\n"
      end

      out << hr
    end

    def width
      @tiles[0].size
    end

    def height
      @tiles.size
    end

    def ripe_for_conquest
      available_tiles = []

      enemy_tiles.select do |t|
        t.neighbors.each_value do |n|
          available_tiles << n unless n.pwned?
        end
      end

      available_tiles
    end

    def enemy_tiles
      @tiles.flatten.select(&:pwned?)
    end
 
    def friendly_resource_tiles
      resource_tiles.select(&:friendly?)
    end

    def enemy_resource_tiles
      resource_tiles.select(&:pwned?)
    end

    def resource_tiles
      @_rt = @tiles.flatten.select(&:resource?)
    end

    def friendly_hive
      hive_tiles.select(&:friendly?)[0]
    end
    
    def enemy_hive
      @_eh ||= hive_tiles.select(&:pwned?)[0]
    end
    
    def hive_tiles
      @_ht ||= @tiles.flatten.select(&:hive?)
    end

  end
end
