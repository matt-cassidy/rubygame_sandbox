require "game/views/test_view"

module Game::Views

  class StartView < Game::Core::View

    def initialize
      super
    end

    def update(seconds, clock)
      @view_manager.add_view TestView.new
      @view_manager.remove_view self
    end

  end

end