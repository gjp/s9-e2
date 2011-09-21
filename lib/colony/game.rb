module Colony
  class Game
    attr_reader :map, :players, :team_resources, :turn

    def initialize
      @map = Map.new
      @players = Player.new
      @team_resources = 0
      @turn = 0
    end
    
    def event_loop
    end
    
  end
end
