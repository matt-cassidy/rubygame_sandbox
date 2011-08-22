require "./game/core/player_input.rb"
require "./game/core/entity.rb"

module Game::Entities

  class Hero < Game::Core::Sprite
    
    def initialize(view, pos)
      super view, pos
      load_script "hero"
      @input = Game::Core::PlayerInput
      @facing = :right
      @acc = Game::Core::Vector2.zero
      @vel = Game::Core::Vector2.zero
    end
    
    def update
      super
      handle_movement
      handle_animation
      handle_collisions
    end

    def handle_movement
      @moving = false
      x, y = 0,0
      if @input.press? :left
        x -= 5
        @facing = :left
        @moving = true
      end
      if @input.press? :right
        x += 5
        @facing = :right
        @moving = true
      end
      if @input.press? :up
        y -= 5
        @facing = :up
        @moving = true
      end 
      if @input.press? :down
        y += 5
        @facing = :down
        @moving = true
      end   
      if(x != 0 || y != 0)
        @pos.x += x
        @pos.y += y
      end
    end

    def handle_animation
      if @moving 
        if @facing == :down
          change_animation :walk_down
        elsif @facing == :up
          change_animation :walk_up
        elsif @facing == :right
          change_animation :walk_right
        elsif @facing == :left
          change_animation :walk_left
        end
      else
        if @facing == :down
          change_animation :stand_down
        elsif @facing == :up
          change_animation :stand_up
        elsif @facing == :right
          change_animation :stand_right
        elsif @facing == :left
          change_animation :stand_left
        end  
      end
      
    end
    
    def handle_collisions
      if @hitbox.colliding? 
        
      end
    end
  
  end

end