module Game::Core

  class View

    @@view_manager
    attr_reader :parent
    attr_reader :entities
    attr_reader :children
    attr_reader :loaded
    attr_reader :visible
    attr_reader :freeze
    attr_reader :quit_requested
    attr_reader :camera
    attr_reader :entities
    attr_reader :surface
    
    def initialize(parent_view)
      @parent = parent_view
      @children = []
      @camera = Camera.new self, [640,480]
      @entities = Hash.new
      @loaded = false
      @visible = false
      @freeze = false
      @quit_requested = false
      add_entity @camera.viewport
      #@surface = Rubygame::Surface.new [640,480]
    end
    
    def view_manager=(view_manager)
      @@view_manager = view_manager
    end
    
    def load
      #implement in sub class
    end
    
    def update
      #implement in sub class
    end

    def draw
      #implement in sub class
    end
    
    def surface
      @@view_manager.screen
    end

    def close
      cancel_close = closing
      return if cancel_close == true
      if not @parent.nil? then
        Log.info "Closing view #{self.class}"
        @parent.children.delete self  
      end
    end
    
    def finished_loading
      @loaded = true
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
      @children << view
    end
    
    def remove_view(view)
      @children.delete view
    end
    
    def add_entity(entity)
      @entities[entity.entity_id] = entity
    end
    
    def remove_entity(entity_id)
      @entities.delete entity_id
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