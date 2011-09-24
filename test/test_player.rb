require 'minitest/autorun'
require_relative '../lib/colony.rb'

include MagicNumbers

describe Player do
  before do
    @map = Map.new
    @player = Player.new(@map, 1, 2)
  end
 
  it "must initialize" do
    @player.hp.must_equal PLAYER_HP
    @player.food.must_equal 0
    @player.moves.must_equal PLAYER_MOVES
  end

  it "must adjust basic stats" do
    @player.adjust_hp(-1).must_equal PLAYER_HP - 1
    @player.adjust_food(2).must_equal 2
    @player.adjust_moves(-2).must_equal PLAYER_MOVES - 2
  end

  it "must remove and return food" do
    @player.adjust_food(10)
    @player.remove_food.must_equal 10
  end

  it "must be movable" do
    @player.move(:right)
    @player.tile.friendly?.must_equal true
    @player.moves.must_equal PLAYER_MOVES - 1
  end

  it "must gather from a resource node" do
    @player.food.must_equal 0
    t = @map.resource_tiles.first
    @player.move_to(t)
    @player.gather
    @player.food.must_equal PLAYER_FOOD_CAP / 2
  end

  it "must play a card" do
    @player.play_card(:speed)
  end
end
