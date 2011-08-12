require "./game/core/entity.rb"

module Game::Entities

  class PlayerPaddle < Game::Core::Entity
    
    MOVE_SPEED = 5.0
    
    def initialize(view, pos)
      @actor = load_script "paddle"
      super view, pos, @actor[:hitbox]
      @image = Rubygame::Surface.new [35,150]
      @image.fill :white
      @hitbox.make_visible
      @ball_reset = true
      @dir = [0,0]
      @input = Game::Core::PlayerInput
    end
  
    def update
      handle_movement
    end
    
    def draw
      @hitbox.blit surface, screen_pos
      @image.blit surface, screen_pos
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