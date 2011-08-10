require "game/entities/pong_ball.rb"
require "game/entities/player_paddle.rb"

module Game::Views
  
  class PongView < Game::Core::View
    
    def initialize
      super
    end
    
    def loading
      @ball = Game::Entities::PongBall.new [280,200]
      @player = Game::Entities::PlayerPaddle.new [10, 10]
      @input = Game::Core::PlayerInput
      @paused = false
    end
    
    def update(clock)
      handle_pause
      handle_quit
      update_ball clock
      
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
    
    def update_ball(clock)
      if not @paused then 
        @ball.update clock
      end
    end
    
  end
  
end