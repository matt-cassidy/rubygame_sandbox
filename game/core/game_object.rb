require "./game/core/goid.rb"
require "./game/core/collision_hitbox.rb"

module Game::Core

  class GameObject
    
    attr_accessor :view
    attr_reader :updated
    attr_reader :events
    attr_reader :pos
    attr_reader :size
    attr_reader :goid
    attr_reader :hitbox
    
    def initialize(pos, size)
      @pos = pos
      @size = size
      @goid = GOID.next
      @events = []
      @hitbox = CollisionHitbox.new pos, size
      @updated = false
    end
    
    def update(clock)
      #implement in sub class  
    end
    
    def draw(surface)
      #implement in sub class
    end
    
    def do_update(clock)
      return if @updated == true
      cool_down_events clock.seconds
      update clock
      @updated = true
    end
    
    def do_draw(surface)
      draw surface
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
    
    def cool_down_events(seconds)
      @events.each { |e| e.cool_down seconds } 
      @events.delete_if {|e| e.is_finished}
    end
    
    def screen_pos
      return @view.camera.get_screen_pos self
    end

  end

end