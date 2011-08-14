require "./game/core/entity.rb"

module Game::Entities

  class PlayerPaddle < Game::Core::Entity
    
    MOVE_SPEED = 5.0
    
    def initialize(view, pos)
      super view, pos, [20,150]
      @image = Rubygame::Surface.new [20,150]
      @image.fill :white
      @hitbox.make_visible
      @ball_reset = true
      @dir = [0,0]
      @input = Game::Core::PlayerInput
      
      regions = { top: [20,0],
                  center_top: [20,38],
                  center: [20,75],
                  center_bottom: [20,113],
                  bottom: [20,150]
                  }
      @hitbox.add_regions regions
    end
  
    def updating
      handle_movement
    end
    
    def drawing
      cblit @image
      cblit @hitbox
    end
    
    def handle_movement
      x, y = 0,0
      y -= 1 if @input.key_pressed?( :up ) # up is down in screen coordinates
      y += 1 if @input.key_pressed?( :down )
      if(x != 0 || y != 0)
        shift [x * MOVE_SPEED, y * MOVE_SPEED]
      end
    end
   
   end
    
end