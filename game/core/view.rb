module Game::Core

  class View

    @@view_manager
    attr_reader :parent
    attr_reader :entities
    attr_reader :children
    attr_reader :loaded
    attr_reader :visible
    attr_reader :active
    attr_reader :quit_requested
    attr_reader :camera
    attr_reader :entities
    attr_reader :input
    attr_reader :collision_tree
    attr_reader :surface
    attr_reader :size
    attr_reader :pos
    
    def initialize(parent_view, pos=[0,0], size=[640,480])
      @parent = parent_view
      @children = []
      @entities = Hash.new
      @loaded = false
      @visible = false
      @active = false
      @quit_requested = false
      @size = size
      @pos = pos
      @camera = Camera.new self, size
      @surface = Rubygame::Surface.new size, 0, [Rubygame::HWSURFACE,Rubygame::DOUBLEBUF]
      @collision_tree = Game::Core::CollisionTree.make size, 5
      add_entity @camera.viewport
    end
    
    def view_manager=(view_manager)
      @@view_manager = view_manager
    end
    
    def load
      #implement in sub class
    end
    
    def _update
      @collision_tree.update
      update
      @entities.each { |id,e| e._update }
    end
    
    def update
      #implement in sub class
    end
    
    def draw
      #implement in sub class
    end    

    def _draw
      draw
      @entities.each { |id,e| e._draw }
    end
    
    def clear
      @surface.fill :black  
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
      activate
    end
    
    def hide
      @visible = false
      deactivate
    end
    
    def visible?
      @visible
    end
    
    def active?
      @active
    end
    
    def deactivate
      @active = false
    end
    
    def activate
      @active = true
    end
    
    def add_view(view)
      @children << view
    end
    
    def remove_view(view)
      @children.delete view
    end
    
    def add_entity(entity)
      @collision_tree.objects << entity
      @entities[entity.entity_id] = entity
    end
    
    def remove_entity(entity_id)
      entity = @entities[entity_id]
      @entities.delete entity
      @collision_tree.objects.delete entity 
    end
    
    def quit_requested?
      return true if @quit_requested
      if PlayerInput.quit_requested? then
        return true
      end
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