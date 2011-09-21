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

    it "should contain hives" do
      #
    end

    it "should build resource nodes" do
      #p @map.resource_nodes
    end

  end
end
