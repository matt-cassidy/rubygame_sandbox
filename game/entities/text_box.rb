require "./game/core/entity.rb"

module Game::Entities
  
  class TextBox < Game::Core::Entity
    
    attr_accessor :color
    attr_accessor :position
    attr_accessor :text
    
    def initialize(view, pos, text, font_size, color,absolute=true)
      super view, pos, [50, 50]
      @font = Rubygame::TTF.new "./resource/ttf/pirulen.ttf", font_size
      @smooth = true
      @color = color
      @surface = nil
      @text = text
      @absolute = absolute
    end
    
    def draw
      @surface = @font.render_utf8 @text, @smooth, @color
      
      if @absolute then
        @surface.blit surface, pos
      else
        @surface.blit surface, screen_pos
      end
    end

  end

end