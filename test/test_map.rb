require 'minitest/autorun'
require_relative '../lib/colony.rb'

include Colony

describe Map do
  include MagicNumbers

  before do
    @map = Map.new
  end
 
  describe "a map" do
    it "should initialize" do
      @map.height.must_equal MAP_ROWS
      @map.width.must_equal MAP_COLS
    end

    it "should build hives" do
      @map.hive_tiles.size.must_equal 2 
    end

    it "should build resource nodes" do
      @map.resource_tiles.size.must_equal RESOURCE_NODE_COUNT
    end

  end
end
