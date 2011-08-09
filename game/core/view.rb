module Game::Core

  class View

    attr_reader :view_manager

    def update(seconds, clock)
      #implement in sub class
    end

    def draw(screen)
      #implement in sub class
    end

    def view_manager=(manager)
      puts "setting view manager "
      @view_manager = manager
    end

  end

end