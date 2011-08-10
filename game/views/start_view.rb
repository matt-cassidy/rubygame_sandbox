require "game/views/menu_view"

module Game::Views

  class StartView < Game::Core::View

    def initialize
      super
    end
    
    def loading
      menu = MenuView.new
      menu.show
      add_view menu
      @input = Game::Core::PlayerInput
    end
    
    def closing
      #handle quit confirm and clean up here
      return false#dont cancel the quit event
    end

  end

end