require "./game/core/game_object.rb"

module Game::Core

  class Entity < GameObject
    
    def initialize(pos, size)
      super pos, size
    end
  
  end

end