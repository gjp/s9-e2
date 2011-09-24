module Colony
  class Enemy
    include MagicNumbers

    attr_reader :moves_per_turn

    def initialize(map)
      @map = map
      @moves_per_turn = ENEMY_BASE_GROWTH
    end

    def grow_territory
      moves = @moves_per_turn
      choices = @map.ripe_for_conquest
      
      while moves > 0 
        tile = pick_from(choices)
        return nil unless tile

        moves = attack(tile, moves)
        choices.delete(tile) unless tile.sentry?

        if moves >= 0
          tile.pwn
          tile.neighbors.each_value do |t|
            choices << t unless t.pwned?
          end
        end
      end

      accelerate_growth(ENEMY_ACCELERATION)
    end

    def attack(tile, moves)
      if tile.sentry?
        moves = tile.sentry.damage(moves)

      elsif tile.friendly?
        moves -= 1

      elsif tile.resource?
        accelerate_growth(ENEMY_CAPTURE_BONUS)
        moves += ENEMY_CAPTURE_BONUS
      end

      moves - 1
    end

    def accelerate_growth(i)
      @moves_per_turn += i
    end

    def pick_from(choices)
      choices.select(&:sentry?).first || choices.sample
    end

  end
end
