require "game/entities/pong_ball.rb"

module Game::Views
  
  class PongView < Game::Core::View
    
    attr_reader :ball
    attr_reader :player
    attr_reader :com
    
    def initialize(parent)
      super parent
    end
    
    def loading

      @ball = Game::Entities::PongBall.new self, [280,200]
      add_entity @ball
      
    end
    
    def updating
      if input.key_pressed? :space then
        @ball.reset
      end
    end
    
    
  end
  
end