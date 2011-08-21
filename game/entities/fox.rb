require "./game/core/entity.rb"

include Game::Core

module Game::Entities

  class Fox < Entity
    
    def initialize(view, pos, animate = true)
      super view, pos
      load_script "fox"
      @angle = 2*Math::PI * rand
    end
    
    def updating
      if @animate == true then
        handle_movement
      end
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