require "rubygame"
include Rubygame


module Game::Core

  class AnimationReel
    
    attr_reader :name
    attr_reader :current_frame_index
    attr_reader :frame_timings
    attr_reader :frames
    attr_reader :row_h
    
    def initialize(name, frame_size, frame_count, row_index, frame_timings)
      @name = name
      @frame_timings = frame_timings
      frame_w = frame_size[0] 
      frame_h = frame_size[1]
      @current_frame_index = -1
      
      @row_h = (frame_h * (row_index + 1)) - (frame_h / 2)
      
      #loop for the number of frames in this animation and grab the center of each frame
      count = 1
      @frames = []
      frame_count.times do
        @frames << (frame_w * count) - (frame_w / 2)
        count += 1
      end
      reset
    end
    
    def move_next
      if @current_frame_index >= @frames.size - 1 then
        reset
      else
        @current_frame_index += 1
      end
    end
    
    def reset
      @current_frame_index = 0
    end
    
    def position
      [@frames[@current_frame_index], @row_h]
    end
    
    def current_frame_time
      @frame_timings[@current_frame_index]  
    end
    
  end

end