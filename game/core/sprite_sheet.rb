require "game/core/sprite_sheet.rb"

module Game::Core

  class SpriteSheet
    
    attr_reader :hash
    attr_reader :surface
    
    def initialize(hash)
      @hash = hash
      @surface = Rubygame::Surface.load "./resource/sprites/#{image}"
    end
    
    def name
      @hash["meta"]["name"]
    end
    
    def image
      @hash["meta"]["image"]
    end
    
    def frames
      @hash["frames"]
    end
    
    def load(frame_key, src_rect)
      frame = frames[frame_key.to_s]["frame"]
      src_rect.x = frame["x"]
      src_rect.y = frame["y"]
      src_rect.h = frame["h"]
      src_rect.w = frame["w"]
      return @surface
    end
    
  end
  
end