require "game/core/entity.rb"
require "game/core/font.rb"

module Game::Entities
  
  class MenuItem
    
    attr_reader :selected
    attr_reader :font
    attr_reader :rect
    
    def initialize(text, font_size, rect_size, click_callback)
      @selected = false
      @font = Game::Core::Font.new "pirulen", font_size
      @font.text = text
      @image = Rubygame::Surface.new(rect_size)
      @image.fill([100, 100, 100])
      @image.set_alpha 0
      @click_callback = click_callback
    end
    
    def w
      @image.w
    end
    
    def h
      @image.h
    end
    
    def select
      @selected = true
      @image.set_alpha 255
    end
    
    def unselect
      @selected = false
      @image.set_alpha 0
    end
    
    def text=(value)
      @textbox.text = value
    end
    
    def blit(surface, pos)
      @image.blit surface, pos
      @font.blit surface, pos
    end
    
    def trigger
      @click_callback.call
    end
    
  end  
  
end