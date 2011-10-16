require 'minitest/autorun'
require_relative '../lib/colony.rb'

include Colony

describe Card do
  before do
    @card = Card.new(name: 'Super Effective') {}
  end
 
  describe "a card" do
    it "should initialize" do
      @card.name.must_equal 'Super Effective'
    end
  end
end
