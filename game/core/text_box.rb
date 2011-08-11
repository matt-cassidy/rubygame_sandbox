require "./game/core/entity.rb"

module Game::Core

  class TextBox < Entity
    
    attr_accessor :color
    attr_accessor :position
    attr_accessor :text
    
    def initialize(pos, text, font_size, color)
      super pos, [50, 50]
      @font = Rubygame::TTF.new "./resource/ttf/pirulen.ttf", font_size
      @smooth = true
      @color = color
      @surface = nil
      @text = text
    end
    
    def draw(surface)
      @surface = @font.render_utf8 @text, @smooth, @color
      @surface.blit surface, pos
    end

  end

end