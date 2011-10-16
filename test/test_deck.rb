require 'minitest/autorun'
require_relative '../lib/colony.rb'

include Colony

describe Deck do
  before do
    @deck = Deck.new
  end
 
  it "must initialize" do
    @deck.size.must_be :>, 0
  end

  it "must draw" do
    s = @deck.size
    c = @deck.draw
    c.is_a?(Card).must_equal true
    @deck.size.must_equal s - 1
  end

  # I'm going to trust that shuffle works.
end
