require "./game/core/entity.rb"
require "./game/core/font.rb"

module Game::Entities
  
  class TextBox < Game::Core::Entity
    
    attr_accessor :font
    
    def initialize(view, pos, size, absolute=true)
      super view, pos, [50, 50]
      @font = Game::Core::Font.new "pirulen", size
      @absolute = absolute
    end
    
    def text=(text)
      @font.text = text
    end
    
    def draw
      if @absolute then
        @font.blit surface, pos
      else
        @font.blit surface, screen_pos
      end
    end

  end

end