
module Game::Core

  class GameClock
    attr_reader :seconds
    
    def initialize(clock)
      @clock = clock
      @seconds = 0
    end
    
    def tick
      @seconds = @clock.tick.seconds
    end
    
    def framerate
      @clock.framerate
    end
        
  end
  
end