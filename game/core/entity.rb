require "./game/core/goid.rb"
require "./game/core/collision_hitbox.rb"
require "./game/core/script_manager.rb"

module Game::Core

  class Entity
    
    attr_reader :view
    attr_reader :updated
    attr_reader :events
    attr_reader :pos
    attr_reader :spos
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
    
    def _update
      return if @updated == true
      cool_down_events
      update
      update_screen_pos
      @updated = true
    end
    
    def _draw
      draw
      @updated = false
    end
    
    def blit(surf, xy=spos, offset=[0,0])
      surf.blit surface, [xy[0] + offset[0], xy[1] + offset[1]]
    end
    
    def move(pos)
      @pos = pos
    end
    
    def shift(pos)
      x = @pos[0] + pos[0]
      y = @pos[1] + pos[1]
      move [x,y]
    end
    
    def cool_down_events
      @events.each { |e| e.cool_down @view.clock.seconds } 
      @events.delete_if {|e| e.is_finished}
    end
    
    def update_screen_pos
      @spos =  @view.camera.get_screen_pos self
      @hitbox.rect.x = @spos[0]
      @hitbox.rect.y = @spos[1]
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