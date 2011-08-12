module Game::Core
  
  class Font
    
    attr_accessor :color
    attr_accessor :text
    attr_accessor :smooth
    attr_accessor :font_size
    
    def initialize(name, size=10)
      @smooth = true
      @color = :white
      @surface = nil
      @text = " "
      @font_name = name
      @font_size = size
      refresh 
    end
    
    def refresh
      @font = Rubygame::TTF.new "./resource/ttf/#{@font_name}.ttf", @font_size
    end
    
    def blit(surface, pos)
      @surface = @font.render_utf8 @text, @smooth, @color
      @surface.blit surface, pos
    end
    
    def get_surf
      @font.render_utf8 @text, @smooth, @color
    end

  end

end