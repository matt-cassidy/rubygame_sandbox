require "game/entities/planet"

module Game::Views

  class AlphaCompView < Game::Core::View
    
    def initialize(parent)
      super parent
    end
    
    def loading
      enable_transparency
      
      planet1 = Game::Entities::Planet.new self, [200, 200]
      add_entity planet1
      
      planet2 = Game::Entities::Planet.new self, [400, 400]
      add_entity planet2
      
    end
    
   end
    
end