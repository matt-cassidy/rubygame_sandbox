require "game/views/test_view.rb"
require "game/views/view_test_view.rb"
require "game/views/pong_view.rb"
require "game/views/camera_view.rb"
require "game/core/player_input.rb"
require "game/entities/menu.rb"

module Game::Views

  class MenuView < Game::Core::View
    
    def initialize
      super
    end
    
    def load
      @menu = Game::Entities::Menu.new [0, 0], [300, 200], 25, [255,255,255], 14
      add_entity @menu
      
      @menu.add_item "Game Logic", method(:menu_game_logic_selected)
      @menu.add_item "Test Camera", method(:menu_test_camera_selected)
      @menu.add_item "Pong!", method(:menu_pong_selected)
      @menu.add_item "View Management", method(:menu_view_mgmt_selected)
      @menu.add_item "Exit", method(:menu_exit_selected)
      @menu.select_by_index 0
      
      
      @input = Game::Core::PlayerInput
    end
    
    def menu_game_logic_selected
      show_view TestView.new
    end
    
    def menu_view_mgmt_selected
      show_view ViewTestView.new
    end
    
    def menu_pong_selected
      show_view PongView.new
    end
    
    def menu_test_camera_selected
      show_view CameraView.new
    end
    
    def menu_exit_selected
      quit
    end
    
    def show_view(view)
      view.show
      @parent.add_view view
      close
    end
    
  end
  
end