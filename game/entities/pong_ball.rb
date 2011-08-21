require "./game/core/entity.rb"
require "./game/core/vector2.rb"

module Game::Entities

  class PongBall < Game::Core::Entity
    
    def initialize(view, pos)
      super view, pos
      load_script "pong_ball"
      @vel = Game::Core::Vector2.zero
      @acc = Game::Core::Vector2.zero
      reset
    end

    def updating
      handle_movement
    end
    
    def reset
      @vel.to_zero!
      @acc.to_zero!
      @pos.x = 320
      @pos.y = 320
    end
    
    def handle_movement  
      
    end
    
  end

end