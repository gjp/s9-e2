require 'minitest/autorun'
require_relative '../lib/colony.rb'

include Colony

describe Map do

  before do
    @map = Map.new
  end
 
  describe "the map" do
    it "must initialize" do
      @map.height.must_equal MAP_ROWS
      @map.width.must_equal MAP_COLS
    end

    it "must build hives" do
      @map.friendly_hive.wont_be_nil
      @map.enemy_hive.wont_be_nil
    end

    it "must build resource nodes" do
      @map.resource_tiles.size.must_equal RESOURCE_NODE_COUNT
    end

    it "must tell us which tiles are ripe for conquest" do
      @map.ripe_for_conquest.size.must_equal 2
    end

  end
end
