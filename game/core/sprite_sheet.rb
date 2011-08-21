require "game/core/sprite_sheet.rb"

module Game::Core

  class SpriteSheet
    
    attr_reader :hash
    attr_reader :image
    attr_reader :image_flip
    attr_reader :rect
    
    def initialize(hash)
      @hash = hash
      @image = Rubygame::Surface.load "./resource/sprites/#{image}"
      
      if scale > 1
        @image = @image.zoom_to @image.w * scale, @image.h * scale, false
      end
      
      @image_flip = @image.flip true, false
       
    end
    
    def name
      @hash["meta"]["name"]
    end
    
    def image
      @hash["meta"]["image"]
    end
    
    def scale
      @hash["meta"]["scale"]
    end
    
    def frames
      @hash["frames"]
    end
    
    def load(frame_key, src_rect)
      frame = frames[frame_key.to_s]["frame"]
      flip =  frames[frame_key.to_s]["flip"]
      src_rect.h = frame["h"] * scale
      src_rect.w = frame["w"] * scale
      src_rect.y = frame["y"] * scale
      
      if flip
        src_rect.x = (@image.w - (frame["x"] * scale)) - (src_rect.w)
        return @image_flip
      else
        src_rect.x = frame["x"] * scale
        return @image
      end
    end
    
  end
  
end