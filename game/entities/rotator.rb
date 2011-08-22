require "./game/core/entity.rb"

include Game::Core

module Game::Entities

  class Rotator < Game::Core::Sprite
    
    def initialize(view, pos)
      super view, pos
      load_script "rotator"
      @angle = 2*Math::PI * rand
    end
    
    def updating
      handle_movement
    end
   
    def handle_movement
      @angle = ( @angle + 2*Math::PI / 4 * @view.clock.seconds) % ( 2*Math::PI)
      direction = [Math.sin(@angle), Math.cos(@angle)]
      if(direction[0] != 0 || direction[1] != 0)
        @pos.x += direction[0]
        @pos.y += direction[1]
      end
    end
      
  end

end