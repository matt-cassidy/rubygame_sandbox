require "./game/core/game_object.rb"

module Game::Core

  class TextBox < GameObject

    def initialize(px, py)
      super px, py
      @font = Rubygame::TTF.new "./resource/ttf/pirulen.ttf", 12
      @smooth = true
      @color = [ 255, 255, 255] 
      @text_surface = @font.render_utf8 " ", @smooth, @color
      @rect = @text_surface.make_rect
      @rect.center = [px,py]
    end
    
    def text=(value)
      @text_surface = @font.render_utf8 value, @smooth, @color
    end
    
    def draw(screen)
      @text_surface.blit screen, @rect 
    end

    def update(px,py)
      @rect.center = [px,py]
    end
  end

end