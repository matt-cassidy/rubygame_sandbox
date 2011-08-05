
module Game::Core
  
  class PlayerInput
    include Rubygame::EventHandler::HasEventHandler
    
    def initialize
      @queue = Rubygame::EventQueue.new
      @queue.enable_new_style_events
      @keys = [] # Keys being pressed
      create_event_hooks
    end
  
    def fetch
      @queue.each { |event| handle( event ) }  
    end
    
    def create_event_hooks
      hooks = {
        Rubygame::Events::KeyPressed => :key_pressed,
        Rubygame::Events::KeyReleased => :key_released,
        Rubygame::QuitEvent => :close,
        :q => :close,
        }
      make_magic_hooks hooks
    end
    
    def key_pressed( event )
      @keys += [event.key]
    end
   
    def key_released( event )
      @keys -= [event.key]
    end
    
    def close
      throw :quit
    end
    
    def key_pressed?(key)
      @keys.include? key
    end
    
  end

end