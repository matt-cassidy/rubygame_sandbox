module Game::Core

  class View

    @@view_manager
    attr_accessor :parent
    attr_reader :entities
    attr_reader :children
    attr_reader :loaded
    attr_reader :visible
    attr_reader :freeze
    attr_reader :quit_requested
    attr_reader :camera
    attr_reader :entities
    attr_reader :surface
    
    def initialize
      @children = []
      @camera = Camera.new [640,480]
      @entities = Hash.new
      @loaded = false
      @visible = false
      @freeze = false
      @quit_requested = false
      #@surface = Rubygame::Surface.new [640,480]
    end
    
    def view_manager=(view_manager)
      @@view_manager = view_manager
    end
    
    def do_load
      add_entity @camera.viewport
      load
      @loaded = true
    end
    
    def load
      #implement in sub class
    end
    
    def do_update
      update
      @entities.each { |id,e| e.do_update }
    end
    
    def update
      #implement in sub class
    end

    def do_draw
      draw
      @entities.each { |id,e| e.do_draw }
    end
    
    def surface
      @@view_manager.screen
    end
    
    def draw
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
      entity.load
    end
    
    def remove_entity(goid)
      entity = @entities[goid]
      @entities.delete goid
      entity.unload
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
    
    def clock
      @@view_manager.clock
    end

  end

end