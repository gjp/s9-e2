module Colony
  class Card

    attr_reader :flavor

    def initialize(*args, &callback)
      @flavor = args[0]
      @action = callback
    end

    def play(*a)
      @action.call(*a)
    end

  end
end
