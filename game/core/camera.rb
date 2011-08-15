require "game/core/viewport.rb"

module Game::Core

  class Camera
    
    BOUNDARY_BOX_WIDTH  = 64
    BOUNDARY_BOX_HEIGHT = 64
    
    attr_reader :pos
    attr_reader :viewport
    
    def initialize(view, camera_size)
      @center = [camera_size[0] / 2, camera_size[1] / 2]
      @offset = [0,0]
      @viewport = Viewport.new view, @center, camera_size
    end
    
    def pos
      @viewport.pos
    end
    
    def follow(entity)
      @viewport.follow entity
    end
    
    def update
      x = pos[0] - @center[0]
      y = pos[1] - @center[1]
      @offset = [x,y]
    end
    
    def get_screen_pos(entity)
      return @center if entity == @viewport
      
      x = entity.pos[0] - @offset[0]
      y = entity.pos[1] - @offset[1]
      
      return [x,y]
    end
    
  end


end