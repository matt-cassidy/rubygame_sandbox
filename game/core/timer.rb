module Game::Core
  
  class Timer
    
    attr_reader :wait
    
    def initialize
      @wait = 0
    end
    
    def wait_for(seconds)
      @wait = seconds
    end
    
    def cool_down(seconds)
      @wait = @wait - seconds
    end
    
    def done?
      @wait <= 0
    end
    
  end
  
end