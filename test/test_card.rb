require 'minitest/autorun'
require_relative '../lib/colony.rb'

include Colony

describe Card do
  before do
    @card = Card.new(
      name:   'I Win',
      flavor: 'Super Effective') {|o| o.size }
  end
 
  it "must initialize" do
    @card.name.must_equal 'I Win'
    @card.flavor.must_equal 'Super Effective'
  end

  it "must be playable" do
    # play_on just calls something on the argument
    a = [1,2,3,4,5]
    @card.play_on(a).must_equal 5
  end

end
