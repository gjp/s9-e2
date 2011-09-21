require 'minitest/autorun'
require_relative '../lib/colony.rb'

include Colony

describe Player do
  before do
    @player = Player.new
  end
 
  describe "a player" do
    it "should initialize" do
      @player.hp.must_equal 0
      @player.food.must_equal 0
      @player.movement.must_equal 0
    end

    it "should adjust basic stats" do
      @player.add_hp(5).must_equal(5)
      @player.add_food(6).must_equal(6)
      @player.add_movement(7).must_equal(7)
      @player.subtract_hp(7).must_equal(-2)
      @player.subtract_food(6).must_equal(0)
      @player.subtract_movement(5).must_equal(2)
    end

    it "can play a card" do
      @player.play_card(:speed)
    end
  end
end
