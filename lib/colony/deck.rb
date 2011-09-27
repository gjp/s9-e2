module Colony
  class Deck

    attr_reader :cards

    def initialize
      @cards = []
      build
      shuffle
    end

    def size
      @cards.size
    end

    def draw
      @cards.pop
    end

    def shuffle
      @cards.shuffle!
    end

    def insert(cards)
      @cards += cards
    end

    private

    def build
      PLAYER_CARDS.each_key do |k|
        PLAYER_CARDS[k].count.times{ @cards << PLAYER_CARDS[k].dup }
      end
    end
  end
end
