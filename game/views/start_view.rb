require "game/views/menu_view"

module Game::Views

  class StartView < Game::Core::View

    def initialize
      super nil
    end
    
    def loading
      show_main_menu
      hide
    end
    
    def closing
      cancel_quit
      show_main_menu
    end
    
    def show_main_menu
      menu = MenuView.new self
      menu.show
      add_view menu
    end
    
    def hack_restart
      @children = []
      show_main_menu
    end

  end

end