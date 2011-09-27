module Colony
  module MagicNumbers
    NEUTRAL  = 0
    FRIENDLY = 1
    ENEMY    = 2

    MAP_COLS = 40
    MAP_ROWS = 20

    RESOURCE_NODE_COUNT = 8
    RESOURCES_GATHERED_PER_ROUND = 5

    WINNING_RESOURCE_COUNT = 600

    ENEMY_BASE_GROWTH = 4
    ENEMY_ACCELERATION = 3
    ENEMY_CAPTURE_BONUS = 10

    PLAYER_MOVES = 5
    PLAYER_HP = 10
    PLAYER_FOOD_CAP = 60
    PLAYER_HAND_SIZE = 2

    SENTRY_HP = 10
    SENTRY_FOOD_COST = 15

    MESSAGE_WIN =
      "Your queen has matured! There she goes, off into the sunset."
    MESSAGE_LOSE =
      "Your hive has been overrun. Everybody dies...even the queen."

    GLYPHS = {
      empty: ' ',
      friendly: '.',
      enemy: '~',
      neutral_node: 'O',
      friendly_node: '*',
      hive: '#',
      sentry: '!'
    }

  end
end
