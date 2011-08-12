module Game::Views

  class HudView < Game::Core::View
    
    def initialize(parent)
      super parent
    end
    
    def load
      @surface = Rubygame::Surface.load("./resource/img/hud_bk.png")
    end
    
    def draw
      @surface.blit surface, [0,408]
    end
    
   end
    
end