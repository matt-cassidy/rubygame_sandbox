
module Game::Views

  class ModalView < Game::Core::View
    
    def initialize(parent)
      super parent, [150, 100], [300, 200]
    end
    
    def load
      @menu = Game::Entities::Menu.new self, [50, 50], [100, 50], 25, [255,255,255], 14
      @menu.add_item "Ok", method(:menu_ok_selected)
      @menu.add_item "Close", method(:menu_close_selected)
      add_entity @menu
      
      @menu.select_by_index 0
    end
    
    def draw
      surface.fill :red
    end
    
    def menu_close_selected
      hide
      @parent.activate
    end
    
    def menu_ok_selected
      hide
      @parent.activate
    end
   
   end
    
end