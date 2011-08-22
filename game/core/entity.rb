require "./game/core/goid.rb"
require "./game/core/vector2.rb"

module Game::Core

  class Entity
    
    attr_reader :id
    attr_reader :view
    attr_reader :events
    attr_reader :pos
    attr_reader :spos
    
    def initialize(view, pos)
      @id = GOID.next
      @view = view
      @pos = Game::Core::Vector2.new pos[0],pos[1]
      @spos = Game::Core::Vector2.zero
      @events = []
    end
    
    def update
      cool_down_events
    end
    
    def adjust
      xy =  @view.camera.get_screen_pos self
      @spos.x = xy[0]
      @spos.y = xy[1]
    end
    
    def draw
      #implement in sub class
    end
    
    def cblit(surf)#center blit
      surf.blit surface, [spos.x - surf.w/2, spos.y - surf.h/2]
    end
    
    def blit(surf, xy, offset=[0,0])
      surf.blit surface, [xy[0] + offset[0], xy[1] + offset[1]]
    end
    
    def move(x,y)
      @pos.x = x
      @pos.y = y
    end
    
    def cool_down_events
      @events.each { |e| e.cool_down @view.clock.seconds } 
      @events.delete_if {|e| e.is_finished}
    end
    
    def surface
      return @view.surface
    end
    
  end

end