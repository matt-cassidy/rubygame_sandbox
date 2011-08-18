require "game/entities/fox"

module Game::Views

  class AlphaCompView < Game::Core::View
    
    def initialize(parent)
      super parent
    end
    
    def loading
      enable_transparency
      
      fox1 = Game::Entities::Fox.new self, [200, 200]
      add_entity fox1
      
      fox2 = Game::Entities::Fox.new self, [400, 400]
      add_entity fox2
      
    end
    
   end
    
end