require "./game/core/entity.rb"

module Game::Entities

  class ComPaddle < Game::Core::Entity
    
    MOVE_SPEED = 5.0
    
    def initialize(pos)
      super pos, "player_paddle"
      @image = Rubygame::Surface.new [35,150]
      @image.fill :white
      @hitbox.make_visible
      @ball_reset = true
      @dir = [0,0]
      @input = Game::Core::PlayerInput
    end
  
    def update(clock)
      handle_movement
    end
    
    def draw(surface)
      @hitbox.draw surface
      @image.blit surface, pos
    end
   
    def handle_movement
      
    end
      
   
   end
    
end