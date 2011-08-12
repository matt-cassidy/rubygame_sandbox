require "./game/core/entity.rb"

module Game::Entities

  class PongBall < Game::Core::Entity
    
    def initialize(view, pos)
      @actor = load_script "pong_ball"
      super view, pos, @actor[:hitbox]
      @image = Rubygame::Surface.load(@actor[:sprite][:path])
      @hitbox.make_visible
      @debugtxt = TextBox.new view, pos, "x,y", 8, :white
      @ball_reset = true
      @dir = [0,0]
      @vel = [0,0]
    end

    def update
      handle_reset
      handle_movement
      handle_collisions
      handle_screen_boundry
      @debugtxt.text = "x=#{pos[0]},y=#{pos[1]}"
      @debugtxt.move @pos
    end
    
    def draw
      @hitbox.draw surface, screen_pos
      @image.blit surface, @hitbox.rect
      @debugtxt.draw
    end
    
    def handle_reset
      if @ball_reset then
        @destination = [280,200]
        @dir = [1,0]
        @vel = [1,1]
        @ball_reset = false
      end
    end
    
    def handle_movement
      x = @dir[0] * @vel[0]
      y = @dir[1] * @vel[1]
      shift [x,y] 
    end
    
    def handle_collisions
      if @hitbox.colliding? 
        
      end
    end
    
    def handle_screen_boundry
      if @pos[0] < 0 or @pos[0] > 640 then
        @ball_reset = true
      end
      if @pos[1] < 0 or @pos[1] > 480 then
        @ball_reset = true
      end
    end
  
  end

end