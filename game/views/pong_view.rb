require "game/entities/pong_ball.rb"

module Game::Views
  
  class PongView < Game::Core::View
    
    def initialize
      super
    end
    
    def loading
      actor = Game::Core::ScriptManager.actors["pong_ball"]
      @ball = Game::Entities::PongBall.new [20,20], actor
      @input = Game::Core::PlayerInput
      @paused = false
    end
    
    def update(clock)
      
      
      
    end
    
    def draw(surface)
      @ball.draw surface
    end
    
    def handle_pause
      if @input.key_pressed?( :space ) then
        @paused = !@paused
      end
    end
    
    def handle_quit
      if @input.key_pressed?( :escape ) then
        quit
      end
    end
    
    def update_ball(seconds, clock)
      if not @paused then 
        @ball.update seconds, clock
      end
    end
    
  end
  
end