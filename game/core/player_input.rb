
module Game::Core
  
  class PlayerInput
    
    class << self
      include Rubygame::EventHandler::HasEventHandler
      
      attr_reader :keysup
      attr_reader :keysdown
      attr_reader :keyspress
      
      def setup
        @queue = Rubygame::EventQueue.new
        @queue.enable_new_style_events
        @keysup = []
        @keyspress = []
        @keysdown = []
        @request_quit = false
        create_event_hooks
      end
    
      def fetch
        clear()
        @queue.each { |event| handle( event ) }  
      end
      
      def press?(key)
        @keyspress.include? key
      end
      
      def down?(key)
        @keysdown.include? key
      end
      
      def up?(key)
        @keysup.include? key
      end
      
      def anykey?
        @keyspress.size > 0
      end
      
      def quit?
        @request_quit
      end
      
      #the following public methods are deprecated
      
      def key_pressed?(key)
        press? key
      end
      
      def quit_requested?
        quit?
      end
      
      private 
      
      def clear()
        @request_quit = false
        @keysdown.clear
        @keysup.clear
      end
      
      def key_pressed( event )
        @keysdown += [event.key]
        @keyspress += [event.key]
      end
     
      def key_released( event )
        @keyspress -= [event.key]
        @keysup += [event.key]
      end
      
      def set_request_quit(event)
        @request_quit = true
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
      
    end
            
  end

end