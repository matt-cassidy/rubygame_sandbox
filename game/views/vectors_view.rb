require "game/entities/mario"
require "game/entities/fox"

module Game::Views

  class VectorsView < Game::Core::View
    
    def initialize(parent)
      super parent
    end
    
    def loading
      @mario = Game::Entities::Mario.new self, [320,240]
      add_entity @mario
    end
   
   end
    
end








