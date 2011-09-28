module Colony
  module MagicNumbers
    NEUTRAL  = 0
    FRIENDLY = 1
    ENEMY    = 2

    MAP_COLS = 40
    MAP_ROWS = 20

    FOOD_NODE_COUNT = 8
    FOOD_GATHERED_PER_ROUND = 5
    FOOD_REQUIRED_PER_PLAYER = 300

    ENEMY_BASE_GROWTH = 4
    ENEMY_ACCELERATION = 3
    ENEMY_CAPTURE_BONUS = 10

    PLAYER_MOVES = 5
    PLAYER_HP = 10
    PLAYER_FOOD_CAP = 30
    PLAYER_HAND_SIZE = 2

    SENTRY_HP = 15
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
