require "./game/core/entity.rb"
require "./game/core/font.rb"

module Game::Entities
  
  class TextBox < Game::Core::Entity
    
    attr_accessor :font
    
    def initialize(view, pos, font_size, absolute=true)
      super view, pos
      @font = Game::Core::Font.new "pirulen", font_size
      @absolute = absolute
    end
    
    def text=(text)
      @font.text = text
    end
    
    def draw
      super
      if not @absolute then
        blit @font
      else
        blit @font, pos.to_a
      end
    end

  end

end