require "./game/core/entity.rb"

include Game::Core

module Game::Entities

  class Fox < Entity
    
    def initialize(view, pos, animate = true)
      @actor = load_script "fox"
      super view, pos, @actor[:hitbox]
      @animate = animate
      @image = Rubygame::Surface.load(@actor[:sprite][:path])
      @hitbox.make_visible
      @angle = 2*Math::PI * rand
    end
    
    def updating
      if @animate == true then
        handle_movement
      else
        shift [0,0]
      end
    end
    
    def drawing
      blit @hitbox
      blit @image
    end
    
    def handle_movement
      @angle = ( @angle + 2*Math::PI / 4 * @view.clock.seconds) % ( 2*Math::PI)
      direction = [Math.sin(@angle), Math.cos(@angle)]
      if(direction[0] != 0 || direction[1] != 0)
        shift direction
      end
    end
      
  end

end