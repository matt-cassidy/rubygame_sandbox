require "game/entities/pong_ball.rb"
require "game/entities/player_paddle.rb"
require "game/entities/com_paddle.rb"

module Game::Views
  
  class PongView < Game::Core::View
    
    attr_reader :ball
    
    def initialize(parent)
      super parent
    end
    
    def load

      @ball = Game::Entities::PongBall.new self, [280,200]
      add_entity @ball
      
      player = Game::Entities::PlayerPaddle.new self, [10, 10]
      add_entity player
      
      com = Game::Entities::ComPaddle.new self, [600, 10]
      add_entity com
      
      @input = Game::Core::PlayerInput
      @paused = false
    end
    
    
  end
  
end