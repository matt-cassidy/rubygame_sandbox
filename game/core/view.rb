module Game::Core

  class View

    attr_accessor :parent
    attr_accessor :children
    attr_accessor :loaded
    attr_accessor :visible
    attr_accessor :freeze
    attr_accessor :quit_requested
    
    def initialize
      @parent = nil
      @children = []
      @loaded = false
      @visible = false
      @freeze = false
    end
    
    def loading
      #implement in sub class
    end
    
    def update(seconds, clock)
      #implement in sub class
    end

    def draw(screen)
      #implement in sub class
    end

    def closing
      #implement in sub class
    end
    
    def close
      cancel = closing
      return if cancel == true
      if @parent.nil? then
        Log.info "Quitting game"
        throw :quit
      else
        Log.info "Closing view #{self.class}"
        @parent.children.delete self  
      end
    end
    
    def loaded?
      @loaded == true
    end
    
    def show
      @visible = true
    end
    
    def hide
      @visible = false
    end
    
    def visible?
      @visible
    end
    
    def freeze
      @freeze = true
    end
    
    def unfreeze
      @freeze = false
    end
    
    def frozen?
      @freeze
    end
    
    def add_view(view)
      view.parent = self
      @children << view
    end
    
    def remove_view(view)
      view.parent = nil
      @children.delete view
    end
    
    def quit_requested?
      @quit_requested
    end
    
    def quit
      @quit_requested = true
    end
    
    def cancel_quit
      quit_requested = false
    end

  end

end