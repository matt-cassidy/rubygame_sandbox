module Game::Views

  class HudView < Game::Core::View
    
    def initialize
      super
    end
    
    def load
      @surface = Rubygame::Surface.load("./resource/img/hud_bk.png")
    end
    
    def draw(surface)
      @surface.blit surface, [0,408]
    end
    
   end
    
end