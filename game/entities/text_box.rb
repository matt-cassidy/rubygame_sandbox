require "./game/core/entity.rb"
require "./game/core/font.rb"

module Game::Entities
  
  class TextBox < Game::Core::Entity
    
    attr_accessor :font
    
    def initialize(view, pos, font_size, absolute=true)
      super view, pos, [50,12]
      @font = Game::Core::Font.new "pirulen", font_size
      @absolute = absolute
    end
    
    def text=(text)
      @font.text = text
    end
    
    def drawing
      if not @absolute then
        blit @font
      else
        blit @font, pos
      end
    end

  end

end