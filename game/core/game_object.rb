require "./game/core/goid.rb"

module Game::Core

  class GameObject
    attr_reader :pos
    attr_reader :goid
     
    def initialize(pos)
      @pos = pos
      @goid = GOID.next
    end
    
    def update  
      #implement in sub class  
    end
    
    def draw(surface)
      #implement in sub class
    end
    
  end

end