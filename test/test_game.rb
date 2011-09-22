require 'minitest/autorun'
require_relative '../lib/colony.rb'

include Colony

describe Game do
  before do
    @game = Game.new
  end
 
  describe "a game" do
    it "should initialize" do
      @game.team_resources.must_equal 0
      @game.round.must_equal 0
      @game.map.wont_be_nil
    end
  end
end
