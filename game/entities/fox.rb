require "./game/core/player_input.rb"
require "./game/core/entity.rb"
require "./game/core/collision_hitbox.rb"
require "./game/core/animation.rb"

include Game::Core

module Game::Entites

  class Fox < Entity
    
    attr_reader :hitbox
    
    def initialize(px, py, actor)
      super px, py
      @input = PlayerInput.new
      @animation = Animation.new actor
      @hitbox = CollisionHitbox.new @animation.sprite_rect
      @hitbox.enable_collision
    end
  
    def update(seconds)
      @input.fetch
      move
      handle_collisions
       
      
      if @input.key_pressed?( :down )   
        @animation.change :walk_down
      end
      if @input.key_pressed?( :up )   
        @animation.change :walk_up
      end
      if @input.key_pressed?( :right )   
        @animation.change :walk_right
      end
      if @input.key_pressed?( :left )   
        @animation.change :walk_left
      end
    end
    
    def draw(screen)
      @animation.animate
      @animation.draw screen, @px, @py
    end
    
    def move
      x, y = 0,0
      x -= 1 if @input.key_pressed?( :left )
      x += 1 if @input.key_pressed?( :right )
      y -= 1 if @input.key_pressed?( :up ) # up is down in screen coordinates
      y += 1 if @input.key_pressed?( :down )
      if(x != 0 || y != 0)
        @px = @px + x
        @py = @py + y
      end
    end
    
    def handle_collisions
      if @hitbox.colliding? 
        puts "s"
      end
    end
  
  end

end