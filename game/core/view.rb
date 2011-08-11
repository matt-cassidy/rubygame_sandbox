module Game::Core

  class View

    attr_accessor :parent
    attr_reader :entities
    attr_reader :children
    attr_reader :loaded
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
    
    def do_load
      load
      @loaded = true
    end
    
    def load
      #implement in sub class
    end
    
    def do_update(clock)
      update clock
      @entities.each { |id,e| e.do_update clock }
    end
    
    def update(clock)
      #implement in sub class
    end

    def do_draw(surface)
      draw surface
      @entities.each { |id,e| e.do_draw surface }
    end
    
    def draw(surface)
      #implement in sub class
    end

    def close
      cancel_close = closing
      return if cancel_close == true
      if not @parent.nil? then
        Log.info "Closing view #{self.class}"
        @parent.children.delete self  
      end
    end
    
    def closing
      #implement in sub class
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