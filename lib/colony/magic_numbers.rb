module Colony
  module MagicNumbers
    NEUTRAL  = 0
    FRIENDLY = 1
    ENEMY    = 2

    MAP_COLS = 40
    MAP_ROWS = 20

    RESOURCE_NODE_COUNT = 8
    RESOURCES_GATHERED_PER_ROUND = 5

    WINNING_RESOURCE_COUNT = 500

    ENEMY_BASE_GROWTH = 4
    ENEMY_ACCELERATION = 2
    ENEMY_CAPTURE_BONUS = 10

    PLAYER_MOVEMENT = 4
    PLAYER_HP = 10
    PLAYER_FOOD_CAP = 10

    SENTRY_HP = 10

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
