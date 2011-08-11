require "game/entities/pong_ball.rb"
require "game/entities/player_paddle.rb"
require "game/entities/com_paddle.rb"

module Game::Views
  
  class PongView < Game::Core::View
    
    attr_reader :ball
    
    def initialize
      super
    end
    
    def loading

      @ball = Game::Entities::PongBall.new [280,200]
      add_entity @ball
      
      player = Game::Entities::PlayerPaddle.new [10, 10]
      add_entity player
      
      com = Game::Entities::ComPaddle.new [600, 10]
      add_entity com
      
      @input = Game::Core::PlayerInput
      @paused = false
    end
    
    def update(clock)
      handle_pause
      handle_quit
      update_entities clock
    end
    
    def draw(surface)
      @entities.each { |id,e| e.do_draw surface }
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
    
    def update_entities(clock)
      return if @paused 
      @entities.each { |id,e| e.do_update clock }
    end
    
  end
  
end