module Game::Core

  class View
    
    COLORKEY = [240, 140, 240]
    
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
    attr_reader :transparent
    attr_reader :input
    attr_reader :collision_tree
    attr_reader :surface
    attr_reader :size
    attr_reader :pos
    attr_reader :level_manager
    attr_reader :world
    
    def initialize(parent_view, pos=[0,0], size=[640,480])
      @parent = parent_view
      @children = []
      @entities = Hash.new
      @loaded = false
      @visible = false
      @active = false
      @quit_requested = false
      @size = size
      @transparent = false
      @pos = pos
      @input = PlayerInput
      @world = Game::Core::WorldMap.new size
    end
    
    def view_manager=(view_manager)
      @@view_manager = view_manager
    end
    
    def load
      @camera = Camera.new self, size
      @surface = Rubygame::Surface.new size
      @collision_tree = Game::Core::CollisionTree.make size, 5
      add_entity @camera.viewport

      @level_manager = Game::Core::LevelManager.new self
      @loaded = true
      loading
    end
    
    def loading
      #implement in sub class
    end
    
    def update
      check_return_to_menu #hack
      check_get_screen_shot
      @collision_tree.update
      updating
      @entities.each { |id,e| e.update }
    end
    
    def updating
      #implement in sub class
    end
    
    def drawing
      #implement in sub class
    end    

    def draw
      drawing
      @entities.each { |id,e| e.draw }
    end
    
    def clear
      if transparent? then
        surface.fill COLORKEY
      else
        surface.fill :black     
      end
    end
    
    def close
      cancel_close = closing
      return if cancel_close == true
      if not @parent.nil? then
        Log.info "Closing view #{self.class}"
        @parent.children.delete self
      else
        quit    
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
    
    def transparent?
      @transparent
    end
    
    def enable_transparency
      surface.colorkey = COLORKEY
      @transparent = true
    end
    
    def disable_transparency
      surface.colorkey = nil
      @transparent = false
    end
    
    def clock
      @@view_manager.clock
    end
    
    def quit
      throw :quit
    end
    
    #this is a hack to get back to the main menu... got tired of flipping around the views
    def check_return_to_menu
      if input.quit_requested? then
        quit
      end
      if input.key_pressed? :escape then
        Log.warn "TODO: fix this"
        @@view_manager.master_view.hack_restart
      end
    end

    def check_get_screen_shot
      if input.up?(:f2) && input.up?(:f2)
        timestamp = Time.new.inspect.gsub(/[ \-:]/,"_")
        filename = "./resource/screenshots/#{timestamp}.png"
        puts "screenshot taken at: #{timestamp} saved at #{filename} "

        @surface.savebmp filename
      end
    end
  end

end