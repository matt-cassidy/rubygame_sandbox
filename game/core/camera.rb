require "rubygame"
require "game/core/text_box.rb"
require "game/core/player_input.rb"
require "observer"

module Game::Core

  class Camera
    include Observable

    BOUNDARY_BOX_WIDTH  = 64
    BOUNDARY_BOX_HEIGHT = 64
    
    attr_reader :pos
    attr_reader :target
    
    def initialize(camera_size)
        @center = [camera_size[0] / 2, camera_size[1] / 2]
        @size = camera_size
        @viewport = Rubygame::Rect.new(0,0, @size[0], @size[1])
        @offset = [0,0]
        @target = nil?
      end

      def resize(camera_size)
        @size = camera_size
      end

      def follow(target)
        @target = target
      end
      
      def pos
        @target.pos
      end
      
      def update(clock)
        @target.update clock
        x = pos[0] - @center[0]
        y = pos[1] - @center[1]
        @offset = [x,y]
      end
      
      def get_screen_pos(entity)
        return @center if entity == target
        
        x = entity.pos[0] - @offset[0]
        y = entity.pos[1] - @offset[1]
        
        return [x,y]
      end
      
  end


end