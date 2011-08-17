require "./game/core/player_input.rb"
require "./game/core/entity.rb"
require "./game/core/animation.rb"

module Game::Entities

  class Hero < Game::Core::Entity
    
    def initialize(view, pos)
      @actor = load_script "hero"
      super view, pos, @actor[:hitbox]
      @input = Game::Core::PlayerInput
      @animation = Game::Core::Animation.make @actor
      @hitbox.make_visible
    end
    
    def updating
      handle_movement
      handle_animation
      handle_collisions
    end

    def drawing
      cblit @hitbox 
      cblit @animation
    end

    def handle_movement
      x, y = 0,0
      x -= 5 if @input.key_pressed?( :left )
      x += 5 if @input.key_pressed?( :right )
      y -= 5 if @input.key_pressed?( :up ) # up is down in screen coordinates
      y += 5 if @input.key_pressed?( :down )
      if(x != 0 || y != 0)
        shift [x, y]
      end
    end

    def handle_animation
      #this needs to be streamlined somehow... animations should be implicit via state
      moving = false
      if @input.key_pressed?( :down )
        moving = true
        @animation.change :walk_down
      elsif @input.key_pressed?( :up )
        moving = true
        @animation.change :walk_up
      elsif @input.key_pressed?( :right )
        moving = true
        @animation.change :walk_right
      elsif @input.key_pressed?( :left )
        moving = true
        @animation.change :walk_left
      end
      if moving == true then
        @animation.animate
      end
    end
    
    def handle_collisions
      if @hitbox.colliding? 
        
      end
    end
  
  end

end