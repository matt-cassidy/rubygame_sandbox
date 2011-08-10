require "observer"

module Game::Core

  class View

    attr_accessor :view_manager
    attr_accessor :loaded
    
    def initialize
      @view_manager = nil
      @loaded = false
      @closing = false
    end
    
    def loading
      #implement in sub class
    end

    def update(who,pos)
      #implement in sub class (used to detect changes in camera, must be update due to observer class)
    end

    def update_screen(seconds, clock)
      #implement in sub class
    end

    def draw(screen)
      #implement in sub class
    end

    def closing
      #implement in sub class
    end
    
    def close
      @view_manager.remove_view self
    end
    
    def loaded?
      @loaded == true
    end

  end

end