require "./game/core/goid.rb"

module Game::Core

  class GameObject
    attr_reader :px
    attr_reader :py
    attr_reader :goid
     
    def initialize(px, py)
      @px = px
      @py = py
      @goid = GOID.next
    end
    
    def update  
      #implement in sub class  
    end
    
    def draw(screen)
      #implement in sub class
    end
    
  end

end