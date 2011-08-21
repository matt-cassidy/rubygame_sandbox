require "rubygame"

module Game::Core

  class Sprite
    
    attr_reader :sprite_info
    attr_reader :frame_index
    attr_reader :current_animation
    attr_reader :frame_time_counter
    attr_reader :rect
    
    def initialize(sprite_info)
      @sprite_info = sprite_info
      @frame_time_counter = 0
      @rect = Rubygame::Rect.new 0,0,1,1
      change sprite_info[:animations].keys[0]
    end
    
    def change(animation_name)
      return if animation_name == @current_animation_name
      @current_animation_name = animation_name
      @frame_index = 0
    end
    
    def animate(speed=100)
      frame_time = current_frame_time
      return if frame_time == nil
      @frame_time_counter += 100
      if @frame_time_counter >= frame_time * speed
        move_next_frame
        @frame_time_counter = 0
      end
    end
    
    def blit(surface, pos)
      surf = Game::Core::SpriteSheetManager.load sheet_name, current_frame, @rect
      surf.blit surface, pos, @rect
    end
    
    def w
      @sprite_info[:size][0]
    end
    
    def h
      @sprite_info[:size][1]
    end
    
    def sheet_name
      @sprite_info[:sheet]
    end
    
    def current_frame_key
      @sprite_info[@frame_index]  
    end
    
    def current_frame
      current_animation[:frames][@frame_index]  
    end
    
    def current_frame_time
      return 0 if not current_animation.has_key? :time
      current_animation[:time][@frame_index]
    end
    
    def current_animation
      @sprite_info[:animations][@current_animation_name]
    end
    
    def move_next_frame
      num_of_frames = current_animation[:frames].size
      return if num_of_frames <= 1
      if @frame_index == num_of_frames - 1 
        @frame_index = 0
      else
        @frame_index += 1
      end
    end
    
  end

end