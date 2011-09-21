require 'minitest/autorun'
require_relative '../lib/colony.rb'

include Colony

describe Tile do
  include MagicNumbers

  before do
    @tile = Tile.new
  end
 
  describe "a tile" do
    it "should initialize" do
      @tile.owner.must_equal NEUTRAL
      @tile.hive?.must_equal false
      @tile.resource?.must_equal false
    end

    it "should build hives" do
      @tile.build_friendly_hive
      @tile.hive?.must_equal true
      @tile.friendly?.must_equal true
      @tile.build_enemy_hive
      @tile.hive?.must_equal true
      @tile.enemy?.must_equal true
    end
  end
end
