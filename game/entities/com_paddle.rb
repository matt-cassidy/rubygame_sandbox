require "./game/core/entity.rb"

module Game::Entities

  class ComPaddle < Game::Core::Entity
    
    MOVE_SPEED = 5.0
    
    def initialize(view, pos)
      super view, pos, [20,150]
      @image = Rubygame::Surface.new [20,150]
      @image.fill :white
      @hitbox.make_visible
      @ball_reset = true
      @dir = [0,0]
      @input = Game::Core::PlayerInput
    end
    
    def updating
      #move_toward_ball
    end
    
    def drawing
      cblit @image
      cblit @hitbox
    end
   
    def move_toward_ball
      if @view.ball.pos[1] > @pos[1] then
        move [-@pos[0], -@pos[1] - MOVE_SPEED]
      end
      if @view.ball.pos[1] < @pos[1] then
        move [@pos[0], @pos[1] + MOVE_SPEED]
      end
    end
      
   
   end
    
end