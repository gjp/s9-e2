module Colony
  include MagicNumbers

  class Card
    attr_reader :name, :flavor, :count

    def initialize(args, &callback)
      @name   = args[:name] 
      @flavor = args[:flavor] 
      @count  = args[:count] 
      @action = callback
    end

    def play_on(*a)
      @action.call(*a)
    end
  end

  PLAYER_CARDS = {
    speed: Card.new(
      name: 'Speed',
      flavor: 'It is by caffeine alone I set my mind in motion.',
      count: 10
  ) { |o| o.adjust_moves(PLAYER_MOVES) },

    scavenge: Card.new(
      name: 'Scavenger',
      flavor: 'Definitely does not taste like chicken.',
      count: 10
  ) { |o| o.adjust_food(SENTRY_FOOD_COST) },

    cologne: Card.new(
      name: 'Alien Cologne',
      flavor: 'Gee, your carapace smells terrific!',
      count: 5
  ) { |o| o.immune },

    sentry: Card.new(
      name: 'Sentry',
      flavor: 'You really wouldn\'t like him when he\'s angry.',
      count: 35
  ) { |o| o.attract_sentry }
  }

end
