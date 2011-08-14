require "game/views/test_view.rb"
require "game/views/viewmgmt_view.rb"
require "game/views/pong_view.rb"
require "game/views/hitbox_view.rb"
require "game/views/camera_view.rb"
require "game/entities/menu.rb"

module Game::Views

  class MenuView < Game::Core::View
    
    def initialize(parent)
      super parent
    end
    
    def loading
      @menu = Game::Entities::Menu.new self, [50, 50], [300, 200], 25, [255,255,255], 14
      @menu.add_item "Game Logic", method(:menu_game_logic_selected)
      @menu.add_item "Test Camera", method(:menu_test_camera_selected)
      @menu.add_item "Collision Detection", method(:menu_collision_selected)
      @menu.add_item "Pong!", method(:menu_pong_selected)
      @menu.add_item "View Management", method(:menu_view_mgmt_selected)
      @menu.add_item "Exit", method(:menu_exit_selected)
      @menu.select_by_index 0
      add_entity @menu
    end
    
    def menu_game_logic_selected
      show_view TestView.new parent
    end
    
    def menu_view_mgmt_selected
      show_view ViewMgmtView.new parent
    end
    
    def menu_pong_selected
      show_view PongView.new self
    end
    
    def menu_test_camera_selected
      show_view CameraView.new parent
    end
    
    def menu_collision_selected
      show_view HitboxView.new parent
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