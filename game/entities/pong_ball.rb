require "./game/core/entity.rb"
require "./game/core/animation.rb"

module Game::Entities

  class PongBall < Game::Core::Entity
    
    def initialize(pos, actor)
      super pos
      @image = Rubygame::Surface.load(actor[:sprite][:path])
      @hitbox.create_rect(pos[0], pos[1], @image.w, @image.h)
      @hitbox.make_visible
      @ball_reset = true
      @dir = [0,0]
      @vel = [0,0]
    end
  
    def update(clock)
      handle_reset
      handle_movement
      handle_collisions
    end
    
    def draw(surface)
      @hitbox.draw surface
      @image.blit surface, @hitbox.rect
    end
    
    def handle_reset
      if @ball_reset then
        move [280,200]
        @dir = [1,0]
        @vel = [1,1]
        @ball_reset = false
      end
    end
    
    def handle_movement
      x = @dir[0]
      y = @dir[1]
      puts "#{x},#{y}"
      move [x,y] 
    end
    
    def handle_collisions
      if @hitbox.colliding? 
        
      end
    end
  
  end

end