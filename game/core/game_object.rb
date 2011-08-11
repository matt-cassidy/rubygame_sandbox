require "./game/core/goid.rb"
require "./game/core/collision_hitbox.rb"

module Game::Core

  class GameObject
    
    attr_accessor :view
    attr_reader :events
    attr_reader :pos
    attr_reader :size
    attr_reader :goid
    attr_reader :hitbox
    attr_reader :destination
    
    def initialize(pos, size)
      @pos = pos
      @size = size
      @goid = GOID.next
      @events = []
      @hitbox = CollisionHitbox.new pos, size
      @destination = @pos
    end
    
    def update(clock)
      #implement in sub class  
    end
    
    def draw(surface)
      #implement in sub class
    end
    
    def move()
      @pos = @destination
      @hitbox.center [@pos[0],@pos[1]]
      
    end
    
    def shift(pos)
      
      if self == @view.camera.target then
        #puts "shift #{pos}"
        @view.camera.focus pos
        
      else
        @destination[0] = @pos[0] + pos[0] - @view.camera.offset[0]
        @destination[1]  = @pos[1] + pos[1] - @view.camera.offset[1]
      end

    end
    
    def cool_down_events(seconds)
      @events.each { |e| e.cool_down seconds } 
      @events.delete_if {|e| e.is_finished}
    end
    

    
  end

end