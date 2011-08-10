require "game/views/menu_view"

module Game::Views

  class StartView < Game::Core::View

    def initialize
      super
    end
    
    def loading
      @view_manager.add_view MenuView.new
      close
    end

  end

end