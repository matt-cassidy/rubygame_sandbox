require "game/entities/rotator"

module Game::Views

  class AlphaCompView < Game::Core::View
    
    def initialize(parent)
      super parent
    end
    
    def loading
      enable_transparency
      
      rotator1 = Game::Entities::Rotator.new self, [200, 200]
      add_entity rotator1
      
      rotator2 = Game::Entities::Rotator.new self, [400, 400]
      add_entity rotator2
      
    end
    
   end
    
end