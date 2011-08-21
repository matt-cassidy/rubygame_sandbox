require "./game/core/goid.rb"
require "./game/core/collision_hitbox.rb"
require "./game/core/script_manager.rb"

module Game::Core

  class Entity
    attr_accessor:visible

    attr_reader :view
    attr_reader :updated
    attr_reader :events
    attr_reader :pos
    attr_reader :spos
    attr_reader :entity_id
    attr_reader :hitbox
    attr_reader :animation_speed
    
    def initialize(view, pos)
      @view = view
      @pos = Game::Core::Vector2.new pos[0],pos[1]
      @entity_id = GOID.next
      @events = []
      @sprite = Sprite.new
      @hitbox = CollisionHitbox.new
      @updated = false
      @visible = true
      @spos =  [0,0]
      @animation_speed = 1
    end
    
    def updating
      #implement in sub class  
    end
    
    def drawing
      #implement in sub class
    end
    
    def update
      return if @updated == true
      cool_down_events
      updating
      @spos =  @view.camera.get_screen_pos self
      @hitbox.update @spos
      @updated = true
      @sprite.animate @animation_speed
    end
    
    def draw
      if @visible
        cblit @hitbox
        cblit @sprite if @sprite.loaded
        drawing
      end
      @updated = false
    end
    
    def cblit(surf)#center blit
      surf.blit surface, [spos[0]-surf.w/2, spos[1]-surf.h/2]
    end
    
    def blit(surf, xy=spos, offset=[0,0])
      surf.blit surface, [xy[0] + offset[0], xy[1] + offset[1]]
    end
    
    def move(x,y)
      @pos.x = x
      @pos.y = y
    end
    
    def shift(vector)
      @pos << vector
    end
    
    def cool_down_events
      @events.each { |e| e.cool_down @view.clock.seconds } 
      @events.delete_if {|e| e.is_finished}
    end
    
    def surface
      return @view.surface
    end
    
    def load_script(script_name)
      script = ScriptManager.actors[script_name]
      if script.nil? then 
        Log.error "Script '#{script_name}' does not exist"
      end
      @sprite.load script
      @hitbox.load script
    end

    def change_animation(name)
      @sprite.change name
    end
    
  end

end