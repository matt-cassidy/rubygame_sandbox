require "game/views/test_view.rb"
require "game/views/view_mgmt_view.rb"
require "game/core/player_input.rb"

module Game::Views

  class MenuView < Game::Core::View
    
    def initialize
      super
    end
    
    def loading
      @menu = Game::Core::Menu.new [0, 0], [300, 200], 25, [255,255,255], 14
      @menu.add_item "Game Logic", method(:menu_game_logic_selected)
      @menu.add_item "View Management", method(:menu_view_mgmt_selected)
      @menu.add_item "Exit", method(:menu_exit_selected)
      @menu.select_by_index 0
      
      @input = Game::Core::PlayerInput
    end
    
    def update(seconds, clock)
      @menu.update seconds
    end
    
    def draw(surface)
      @menu.draw surface
    end
    
    def menu_game_logic_selected
      test = TestView.new
      test.show
      @parent.add_view test
      close
    end
    
    def menu_view_mgmt_selected
      viewmgmt = ViewMgmtView.new
      viewmgmt.show
      @parent.add_view viewmgmt
      close
    end
    
    def menu_exit_selected
      quit
    end
    
  end
  
end