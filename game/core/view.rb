module Game::Core

  class View

    attr_accessor :parent
    attr_reader :entities
    attr_reader :children
    attr_accessor :loaded
    attr_reader :visible
    attr_reader :freeze
    attr_reader :quit_requested
    attr_reader :camera
    attr_reader :entities
    
    def initialize
      @parent = nil
      @children = []
      @camera = Camera.new [640,480]
      @entities = Hash.new
      @loaded = false
      @visible = false
      @freeze = false
      @quit_requested = false
      
      add_entity @camera.viewport
    end
    
    def loading
      #implement in sub class
    end
    
    def update(clock)
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
    
    def add_entity(entity)
      entity.view = self
      @entities[entity.goid] = entity
    end
    
    def remove_entity(goid)
      @entities.delete goid
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