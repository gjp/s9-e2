require 'minitest/autorun'
require_relative '../lib/colony.rb'

include Colony

describe Tile do
  include MagicNumbers

  before do
    @tile = Tile.new
  end
 
  describe "a tile" do
    it "must initialize" do
      @tile.owner.must_equal NEUTRAL
      @tile.hive?.must_equal false
      @tile.resource?.must_equal false
      @tile.sentry?.must_equal false
    end

    it "must build friendly hive" do
      @tile.build_friendly_hive
      @tile.hive?.must_equal true
      @tile.friendly?.must_equal true
    end

    it "must build enemy hive" do
      @tile.build_enemy_hive
      @tile.hive?.must_equal true
      @tile.pwned?.must_equal true
    end

    it "must build a sentry" do
      @tile.build_sentry
      @tile.sentry?.must_equal true
    end

    it "must be friendable" do
      @tile.friendly
      @tile.owner.must_equal FRIENDLY
    end

    it "must be pwnable" do
      @tile.pwn
      @tile.owner.must_equal ENEMY
    end

    it "must be a good neighbor" do
      t = Tile.new
      @tile.connect(:south, t)
      @tile.neighbor(:south).must_equal t
    end

  end
end
