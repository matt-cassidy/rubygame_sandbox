require "game/core/vector2"

module Game::Entities

  class Mario < Game::Core::Entity
    
    ZERO = 0.0
    GROUND_Y = 400
    JUMP_ACCEL_RATE = 1.5
    MOVE_ACCEL_RATE = 1
    MAX_SPEED = 4.0
    GROUND_FRICTION = 0.1
    AIR_FRICTION = 0.8
    GRAVITY = 0.3
    
    KEY_JUMP = :space
    KEY_RIGHT = :right
    KEY_LEFT = :left
     
    attr_reader :image
    attr_reader :pos
    attr_reader :acc
    attr_reader :vel
    attr_reader :jumping  
    
    def initialize(view,pos)
      super view, pos, [15,32]
      
      @actor = load_script "mario"
      @animation = Game::Core::Animation.make @actor
      
      @debug1 = Game::Core::Font.new "pirulen", 10
      @debug2 = Game::Core::Font.new "pirulen", 10
      @debug3 = Game::Core::Font.new "pirulen", 10
      @debug4 = Game::Core::Font.new "pirulen", 10
      @debug5 = Game::Core::Font.new "pirulen", 10
      @debug6 = Game::Core::Font.new "pirulen", 10
      
      @hitbox.make_visible
      
      @input = Game::Core::PlayerInput
      
      max_pos_speed = Game::Core::Vector2.new(MAX_SPEED, MAX_SPEED + 10)
      max_neg_speed = Game::Core::Vector2.new(-MAX_SPEED, -MAX_SPEED - 10)
      
      @acc = Game::Core::Vector2.zero
      @acc.clamp max_neg_speed, max_pos_speed
      
      @vel = Game::Core::Vector2.zero
      @vel.clamp max_neg_speed, max_pos_speed
      
      @vpos = Game::Core::Vector2.new pos[0], pos[1]
      
      @airtime = 0.0
      @facing = 1
      
      @animation.change :stand_right
    end
     
    def updating
      handle_movement
      handle_animation
      update_debug_messages
    end
    
    def update_debug_messages
      air = "%0.2f" % @airtime
      direction = "%0.2f" %  @vel.direction
      speed = "%0.2f" %  @vel.length
      @debug1.text = "airtime   [#{air}]"
      @debug2.text = "position  #{@vpos.to_s_f}"
      @debug3.text = "direction [#{direction}]"
      @debug4.text = "velocity  #{@vel}"
      @debug5.text = "accel  #{@acc}"
      @debug6.text = "speed [#{speed} px/s]"
    end
    
    def drawing
      cblit @hitbox
      cblit @animation
      blit @debug1, [10,10]
      blit @debug2, [10,25]
      blit @debug3, [10,40]
      blit @debug4, [400,10]
      blit @debug5, [400,25]
      blit @debug6, [400,40]
    end
    
    def moving_vert?
      @airtime > ZERO
    end
    
    def moving_hort?
      @vel.x != ZERO
    end
    
    def accelerating?
      @acc.x != ZERO
    end
    
    def on_ground?
      @vpos.y >= GROUND_Y
    end
    
    def above_ground?
      @vpos.y < GROUND_Y
    end
    
    def handle_movement
      seconds = @view.clock.seconds
      
      #jump
      if @input.press? KEY_JUMP and not moving_vert?
        @acc.y = -JUMP_ACCEL_RATE
      end
      
      #move left and right
      if @input.press? KEY_RIGHT
        @acc.x += MOVE_ACCEL_RATE
        @facing = 1
      elsif @input.press? KEY_LEFT
        @acc.x -= MOVE_ACCEL_RATE
        @facing = 2
      else
        @acc.x = ZERO
      end
      
      #physics
      if moving_vert? and not accelerating? #air 
        
        @acc.y += GRAVITY * @airtime
      
      elsif moving_vert? and accelerating? #moving in air 
        
        @acc.y += GRAVITY * @airtime
        @acc.x += (-@acc.x * AIR_FRICTION)
        
  
      elsif moving_hort? and not accelerating?
        
        @acc.x += (-@vel.x * GROUND_FRICTION).round(2)
        @acc.x = -@vel.x if @acc.x == ZERO
        
      end
      
      @vel << @acc
      @vpos << @vel 
      
      #touching ground logic   
      if on_ground?
        @vpos.y = GROUND_Y
        @acc.y = ZERO
        @vel.y = ZERO
        @airtime = ZERO
      elsif above_ground?
        @airtime += seconds
      end
      
      move @vpos.to_a
    end
    
    def handle_animation
    
      if moving_vert?
        
        if @facing == 1
          @animation.change :jump_right
        elsif @facing == 2
          @animation.change :jump_left
        end
      
      elsif moving_hort?
        
        if @facing == 1
          @animation.change :walk_right
        elsif @facing == 2
          @animation.change :walk_left
        else
          @animation.change :walk_right
        end
        
      else
        
        if @facing == 1
          @animation.change :stand_right
        else
          @animation.change :stand_left
        end
          
      end
      
      @animation.animate
    end

    
  end
  
end