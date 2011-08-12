module Game::Views

  class TransparencyView < Game::Core::View
    
    def initialize(parent)
      super parent
    end
    
    def loading
      @image = Rubygame::Surface.load("./resource/img/trans.png")
      surface.set_alpha 150
    end
    
    def drawing
      @image.blit surface, [0,0]
    end
    
   end
    
end