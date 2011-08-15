
module Game::Core
  
  class PlayerInput
    
    class << self
      include Rubygame::EventHandler::HasEventHandler
      
      def setup
        @queue = Rubygame::EventQueue.new
        @queue.enable_new_style_events
        @keys = [] # Keys being pressed
        @request_quit = false
        create_event_hooks
      end
    
      def fetch
        @request_quit = false
        @queue.each { |event| handle( event ) }  
      end
      
      def create_event_hooks
        hooks = 
        {
          Rubygame::Events::KeyPressed => :key_pressed,
          Rubygame::Events::KeyReleased => :key_released,
          Rubygame::Events::QuitRequested => :set_request_quit
        }
        make_magic_hooks hooks
      end
      
      def key_pressed( event )
        @keys += [event.key]
      end
     
      def key_released( event )
        @keys -= [event.key]
      end
      
      def key_pressed?(key)
        @keys.include? key
      end
      
      def set_request_quit(event)
        @request_quit = true
      end
      
      def anykey_pressed?
        @keys.size > 0
      end
      
      def quit_requested?
        @request_quit
      end
      
    end
            
  end

end