require "./game/core/entity.rb"
require "matrix"

module Game::Entities

  class PongBall < Game::Core::Entity
    
    MAX_VEL = 30
    
    def initialize(view, pos)
      super view, pos, [32,32]
      @image = Rubygame::Surface.load("./resource/img/planet_ff.png")
      @vvel = Vector[0,0]
      @vpos = Vector[0,0]
      @vacc = Vector[0,0]
      reset
    end

    def updating
      bounce_screen
      handle_movement
    end
    
    def drawing
      cblit @image
    end
    
    def reset
      @vvel = Vector[rand(5), rand(5)]
      @vacc = Vector[0,0]
      @vpos = Vector[320,320]
      move
    end
    
    def move
      p = @vvel + @vpos + @vacc
      @pos = [p[0],p[1]]
    end
    
    def handle_movement  
      move 
    end
    
  end

end