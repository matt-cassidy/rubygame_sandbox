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
    attr_reader :offset
    attr_accessor :size

    def initialize(camera_size)
      
        x = camera_size[0] / 2
        y = camera_size[1] / 2
        
        @size = camera_size
        @viewport = Rubygame::Rect.new(0,0, @size[0], @size[1])
        @pos = [x,y]
        @target = nil?
        @offset = [0,0]
      end

      def resize(camera_size)
        @size = camera_size
      end

      def follow(target)
        @target = target
      end
      
      def reset
        @offset = [0,0]
      end

      def focus(pos)
        @offset = pos
        @pos[0] = @pos[0] + pos[0]
        @pos[1] = @pos[1] + pos[1]
      end
      
  end


end