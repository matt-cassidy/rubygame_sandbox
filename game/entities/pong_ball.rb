require "./game/core/entity.rb"
require "./game/core/animation.rb"

module Game::Entities

  class PongBall < Entity
    
    def initialize(pos, actor)
      super pos
      @image = Rubygame::Surface.load "./resource/img/planet_ff.png"
      @hitbox.create_rect(pos[0], pos[1], actor[:hitbox][0], actor[:hitbox][1])
      @hitbox.make_visible
    end
  
    def update(seconds)
      handle_movement
      handle_animation
      handle_collisions
    end
    
    def draw(screen)
      @hitbox.draw screen
      @image.blit screen, @pos
    end
    
    def handle_movement
      
    end
    
    def handle_animation
      
    end
    
    def handle_collisions
      if @hitbox.colliding? 
        
      end
    end
  
  end

end