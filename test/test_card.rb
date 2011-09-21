require 'minitest/autorun'
require_relative '../lib/colony.rb'

include Colony

describe Card do
  before do
    @card = Card.new('Flava') {}
  end
 
  describe "a deck of cards" do
    it "should initialize" do
      @card.flavor.must_equal 'Flava'
    end
  end
end
