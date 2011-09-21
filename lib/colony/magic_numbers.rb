module Colony
  module MagicNumbers
    NEUTRAL  = 0
    FRIENDLY = 1
    ENEMY    = 2

    MAP_COLS = 40
    MAP_ROWS = 20

    RESOURCE_NODE_COUNT = 8

    WINNING_RESOURCE_COUNT = 100

    ENEMY_EXPANSION_RATE = 4
    ENEMY_EXPANSION_FACTOR = 2

    PLAYER_MOVEMENT = 4
    PLAYER_HP = 10
    PLAYER_FOOD_CAP = 10

    GLYPHS = {
      empty: ' ',
      friendly: '.',
      enemy: '~',
      neutral_node: 'o',
      friendly_node: '*',
      hive: '#',
      sentry: '!'
    }

  end
end
