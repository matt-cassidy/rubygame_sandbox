require "./game/core/entity.rb"

module Game::Entities

  class PlayerPaddle < Game::Core::Entity
    
    def initialize(pos)
      super pos, "player_paddle"
      @image = Rubygame::Surface.new [50,150]
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
      @image.blit surface, @hitbox.rect
    end
    
    def handle_movement
      if input.key_pressed(:down)
        @dir[1] -= 1
      end
      if input.key_pressed(:up)
        @dir[1] += 1
      end
    end
   
   end
    
end