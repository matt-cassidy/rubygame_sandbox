module Game::Views

  class TransparencyView < Game::Core::View
    
    def initialize(parent)
      super parent
    end
    
    def loading
      #this is slow for some reason...
      #@image = Rubygame::Surface.load("./resource/img/trans.png")
      
      #a basic color is much faster
      @image = Rubygame::Surface.new [640,480]
      @image.fill :green
      
      surface.set_alpha 150
    end
    
    def drawing
      @image.blit surface, [0,0]
    end
    
    def clear
      
    end
    
    
   end
    
end