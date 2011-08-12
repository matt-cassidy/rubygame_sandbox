require "game/views/menu_view"

module Game::Views

  class StartView < Game::Core::View

    def initialize
      super nil
    end
    
    def loading
      menu = MenuView.new self
      menu.show
      add_view menu
      hide
    end
    
    def closing
      #handle quit confirm and clean up here
      Log.info "Quitting game"
      throw :quit
    end

  end

end