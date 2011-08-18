require "game/entities/menu.rb"

module Game::Views

  class MenuView < Game::Core::View
    
    def initialize(parent)
      super parent
    end
    
    def loading
      @menu = Game::Entities::Menu.new self, [50, 50], [300, 200], 25, [255,255,255], 14

      @menu.add_item "Tile System", method(:menu_game_logic_selected)
      @menu.add_item "Parallax System", method(:menu_parallax_logic_selected)
      @menu.add_item "Level Loader", method(:menu_level_loader_selected)
      @menu.add_item "Vectors", method(:menu_vectors_selected)
      @menu.add_item "Test Camera", method(:menu_test_camera_selected)

      @menu.add_item "Collision Detection", method(:menu_collision_selected)
      @menu.add_item "Input", method(:menu_input_selected)
      @menu.add_item "View Management", method(:menu_view_mgmt_selected)
      @menu.add_item "Exit", method(:menu_exit_selected)
      @menu.select_by_index 0
      add_entity @menu
    end
    
    def menu_game_logic_selected
      require "game/views/test_view.rb"
      show_view TestView.new parent
    end

    def menu_parallax_logic_selected
      require "game/views/parallax_view.rb"
      show_view ParallaxView.new parent
    end

    def menu_level_loader_selected
      require "game/views/level_view.rb"
      show_view LevelView.new parent
    end

    def menu_view_mgmt_selected
      require "game/views/viewmgmt_view.rb"
      show_view ViewMgmtView.new parent
    end
    
    def menu_input_selected
      require "game/views/input_view.rb"
      show_view InputView.new self
    end
    
    def menu_test_camera_selected
      require "game/views/camera_view.rb"
      show_view CameraView.new parent
    end
    
    def menu_collision_selected
      require "game/views/hitbox_view.rb"
      show_view HitboxView.new parent
    end  
    
    def menu_vectors_selected
      require "game/views/vectors_view.rb"
      show_view VectorsView.new parent
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