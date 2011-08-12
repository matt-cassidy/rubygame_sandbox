require "./game/core/goid.rb"
require "./game/core/collision_hitbox.rb"
require "./game/core/script_manager.rb"

module Game::Core

  class Entity
    
    attr_reader :view
    attr_reader :updated
    attr_reader :events
    attr_reader :pos
    attr_reader :size
    attr_reader :entity_id
    attr_reader :hitbox
    
    def initialize(view, pos, size)
      @view = view
      @pos = pos
      @size = size
      @entity_id = GOID.next
      @events = []
      @hitbox = CollisionHitbox.new pos, size
      @updated = false
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
    
    def unload
      #implement in sub class
    end
    
    def do_update
      return if @updated == true
      cool_down_events
      update
      @updated = true
    end
    
    def do_draw
      draw
      @updated = false
    end
    
    def move(pos)
      @pos = pos
      @hitbox.center [pos[0],pos[1]]
    end
    
    def shift(pos)
      x = @pos[0] += pos[0]
      y = @pos[1] += pos[1]
      move [x,y]
    end
    
    def cool_down_events
      @events.each { |e| e.cool_down @view.clock.seconds } 
      @events.delete_if {|e| e.is_finished}
    end
    
    def screen_pos
      return @view.camera.get_screen_pos self
    end
    
    def surface
      return @view.surface
    end
    
    def load_script(script_name)
      script = ScriptManager.actors[script_name]
      if script.nil? then 
        Log.error "Script '#{script_name}' does not exist"
      end
      return script
    end

  end

end