require "game/views/menu_view"

module Game::Views

  class StartView < Game::Core::View

    def initialize
      super nil
    end
    
    def load
      menu = MenuView.new self
      menu.show
      add_view menu
      @input = Game::Core::PlayerInput
    end
    
    def update
      if @input.quit_requested? then
        quit
      end
    end
    
    def closing
      #handle quit confirm and clean up here
      Log.info "Quitting game"
      throw :quit
    end

  end

end