require 'minitest/autorun'
require_relative '../lib/colony.rb'

include Colony

describe Enemy do
  before do
    @map = Map.new
    @enemy = Enemy.new(@map)
  end
 
  it "must initialize" do
    @enemy.moves_per_turn.must_equal ENEMY_BASE_GROWTH
  end

  it "must accelerate growth" do
    @enemy.accelerate_growth(10).must_equal ENEMY_BASE_GROWTH + 10
  end

  it "must attack neutral tiles" do
    @enemy.attack(Tile.new, 10).must_equal 9
  end

  it "must attack friendly tiles" do
    t = Tile.new
    t.friendly
    @enemy.attack(t, 10).must_equal 8
  end

  it "must attack sentry tiles" do
    t = Tile.new
    t.friendly
    t.attract_sentry
    @enemy.attack(t, 15).must_equal (15 - 1 - SENTRY_HP)
  end

  it "must choose to attack sentries first" do
    # Probabalistic test...random selection is random
    tiles = []
    100.times{ tiles << Tile.new }
    s = tiles[rand(100)]
    s.friendly
    s.attract_sentry
    t = @enemy.pick_from(tiles)
    t.sentry?.must_equal true
  end

  it "must grow territory" do
    @enemy.grow_territory
    @map.enemy_tiles.size.must_equal ENEMY_BASE_GROWTH + 1
    @enemy.grow_territory
    @map.enemy_tiles.size.must_equal(
      2 * ENEMY_BASE_GROWTH + 1 + ENEMY_ACCELERATION
    )
  end

  it "must be slowed by sentries" do
    # Drop a sentry right next to the hive
    # It will absorb the first growth unless the constants are tweaked hard
    c = @map.ripe_for_conquest.first
    c.friendly
    c.attract_sentry
    @enemy.grow_territory
    @map.enemy_tiles.size.must_equal 1
  end

end

