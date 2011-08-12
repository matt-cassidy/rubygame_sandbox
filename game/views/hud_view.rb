module Game::Views

  class HudView < Game::Core::View
    
    def initialize(parent)
      super parent, [0,parent.surface.h-100], [640,100]
    end
    
    def loading
      @hud = Rubygame::Surface.load("./resource/img/hud_bk.png")
    end
    
    def drawing
      surface.fill :red
      @hud.blit surface, [0,0]
    end
    
   end
    
end