require "game/core/vector2"

module Game::Entities

  class Mario < Game::Core::Entity
    
    ZERO = 0.0
    GROUND_Y = 400
    JUMP_ACCEL_RATE = 1.0
    WALK_ACCEL_RATE = 0.2
    RUN_ACCEL_RATE = 0.5
    SLIDE_FRICTION = 2
    AIR_FRICTION = 0.5
    GRAVITY = 0.3
    MAX_RUN_SPEED = 14
    MAX_WALK_SPEED = 5
    
    KEY_JUMP = :space
    KEY_RIGHT = :right
    KEY_LEFT = :left
    KEY_DOWN = :down
    KEY_RUN = :left_shift
    
    def initialize(view,pos)
      super view, pos, [64,128]
      
      @actor = load_script "mario"
      @animation = Game::Core::Animation.make @actor
      
      @controls = Game::Core::Font.new "pirulen", 10
      @controls.text = "Shift=Run, Space=Jump, Arrows=Move"
      
      @debug1 = Game::Core::Font.new "pirulen", 10
      @debug2 = Game::Core::Font.new "pirulen", 10
      @debug3 = Game::Core::Font.new "pirulen", 10
      @debug4 = Game::Core::Font.new "pirulen", 10
      @debug5 = Game::Core::Font.new "pirulen", 10
      @debug6 = Game::Core::Font.new "pirulen", 10
      
      #@hitbox.make_visible
      
      @input = Game::Core::PlayerInput
      
      @acc = Game::Core::Vector2.zero
      @vel = Game::Core::Vector2.zero
      @vpos = Game::Core::Vector2.new pos[0], pos[1]
      
      @airtime = 0.0
      @facing = 1
      @ducking = false
      @sliding = false
      
      @animation.change :stand_right
    end
     
    def updating
      handle_movement
      handle_animation
      update_debug_messages
    end
    
    def update_debug_messages
      air = "%0.2f" % @airtime
      direction = "%0.2f" %  (@vel.direction - 360)
      speed = "%0.2f" %  @vel.length
      @debug1.text = "airtime   [#{air}]"
      @debug2.text = "position  #{@vpos.to_s_formated}"
      @debug3.text = "direction [#{direction}]"
      @debug4.text = "velocity  #{@vel}"
      @debug5.text = "accel  #{@acc}"
      @debug6.text = "speed [#{speed} px/s]"
    end
    
    def drawing
      cblit @hitbox
      cblit @animation
      blit @controls, [10,470]
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
    
    def moving_right
      @vel.x > ZERO
    end
    
    def moving_left
      @vel.x < ZERO
    end
    
    def accelerating_opposite_dir?
      return true if @vel.x < ZERO and @acc.x > ZERO 
      return true if @vel.x > ZERO and @acc.x < ZERO
      return false
    end
    
    def moving_fast?
      return true if moving_left and @vel.x < -MAX_WALK_SPEED
      return true if moving_right and @vel.x > MAX_WALK_SPEED
    end
    
    def handle_movement
      seconds = @view.clock.seconds
      
      #TODO:need to implement some sort of jump timing, 
      #longer player holds jump the higher you should jump
      #also player shouldnt be able to hold jump key and jump as soon as he lands
      
      #jump
      if @input.press? KEY_JUMP and not moving_vert?
        @acc.y = -JUMP_ACCEL_RATE
      end
      
      #run
      if @input.press? KEY_RUN
        accel_rate = RUN_ACCEL_RATE
        @running = true
      else
        accel_rate = WALK_ACCEL_RATE
        @running = false
      end
      
      #duck
      if @input.press? KEY_DOWN
        @ducking = true
      else
        @ducking = false
      end
      
      #move left and right
      if @input.press? KEY_RIGHT and not @ducking
        @acc.x = accel_rate
        @facing = 1 if not moving_vert?
      elsif @input.press? KEY_LEFT and not @ducking
        @acc.x = -accel_rate
        @facing = 2 if not moving_vert?
      else
        @acc.x = ZERO
      end
      
      @sliding = false
      
      #physics
      if moving_vert? and not accelerating? # air 
        
        @acc.y += GRAVITY * @airtime
      
      elsif moving_vert? and accelerating? # moving in air 
        
        @acc.y += GRAVITY * @airtime
        @acc.x += (-@acc.x * AIR_FRICTION)
      
      elsif accelerating_opposite_dir? and moving_fast? # switch direction
        
        @sliding = true
        @acc.x += (-@vel.x * 0.05).round(2)
        @acc.x = -@vel.x if @acc.x == ZERO
        
      elsif @ducking and moving_fast? # duck slide 
        
        @acc.x += (-@vel.x * 0.05).round(2)
        @acc.x = -@vel.x if @acc.x == ZERO
          
      elsif moving_hort? and @running and not accelerating? # stop running
        
        @acc.x += (-@vel.x * 0.3).round(2)
        @acc.x = -@vel.x if @acc.x == ZERO
        
      elsif moving_hort? and not accelerating? or accelerating_opposite_dir? # stop walking
        
        @acc.x += (-@vel.x * 0.5).round(2)
        @acc.x = -@vel.x if @acc.x == ZERO
          
      end
      
      @vel << @acc
      
      #control max speed
      if @running 
        @vel.x = -MAX_RUN_SPEED if @vel.x < -MAX_RUN_SPEED 
        @vel.x = MAX_RUN_SPEED if @vel.x > MAX_RUN_SPEED
      else
        @vel.x = -MAX_WALK_SPEED if @vel.x < -MAX_WALK_SPEED
        @vel.x = MAX_WALK_SPEED if @vel.x > MAX_WALK_SPEED
      end
      
      
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
      
      elsif @sliding
        
        if @facing == 1
          @animation.change :slide_right
        elsif @facing == 2
          @animation.change :slide_left
        else
          @animation.change :slide_right
        end
      
      elsif moving_hort? and not @ducking
        
        if @facing == 1
          @animation.change :walk_right
        elsif @facing == 2
          @animation.change :walk_left
        else
          @animation.change :walk_right
        end
      
      elsif @ducking and not moving_vert?
        
        if @facing == 1
          @animation.change :duck_right
        elsif @facing == 2
          @animation.change :duck_left
        else
          @animation.change :duck_right
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