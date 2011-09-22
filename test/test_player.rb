require 'minitest/autorun'
require_relative '../lib/colony.rb'

include MagicNumbers

describe Player do
  before do
    #FIXME: the 2nd argument is temporary
    @player = Player.new(nil, 1)
  end
 
  describe "a player" do
    it "must initialize" do
      @player.hp.must_equal PLAYER_HP
      @player.food.must_equal 0
      @player.movement.must_equal PLAYER_MOVEMENT
    end

    it "must adjust basic stats" do
      @player.adjust_hp(-1).must_equal(PLAYER_HP - 1)
      @player.adjust_food(2).must_equal(2)
      @player.adjust_movement(-2).must_equal(PLAYER_MOVEMENT - 2)
    end
    
    it "can play a card" do
      @player.play_card(:speed)
    end
  end
end
