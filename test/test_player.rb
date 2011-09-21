require 'minitest/autorun'
require_relative '../lib/colony.rb'

include MagicNumbers

describe Player do
  before do
    @player = Player.new(1)
  end
 
  describe "a player" do
    it "must initialize" do
      @player.hp.must_equal PLAYER_HP
      @player.food.must_equal 0
      @player.movement.must_equal PLAYER_MOVEMENT
    end

    it "must adjust basic stats" do
      @player.add_hp(1).must_equal(PLAYER_HP + 1)
      @player.add_food(2).must_equal(2)
      @player.add_movement(3).must_equal(PLAYER_MOVEMENT + 3)
    end
    
    it "must subtract basic stats" do
      @player.subtract_hp(4).must_equal(PLAYER_HP - 4)
      @player.subtract_food(5).must_equal(-5)
      @player.subtract_movement(6).must_equal(PLAYER_MOVEMENT - 6)
    end

    it "can play a card" do
      @player.play_card(:speed)
    end
  end
end
