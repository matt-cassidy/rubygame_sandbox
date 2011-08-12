
module Game::Views

  class ModalView < Game::Core::View
    
    def initialize(parent)
      super parent
    end
    
    def load
      @menu = Game::Entities::Menu.new self, [300, 300], [100, 50], 25, [255,255,255], 14
      @menu.add_item "Ok", method(:menu_ok_selected)
      @menu.add_item "Close", method(:menu_close_selected)
      add_entity @menu
      
      @menu.select_by_index 0
      
      @background = Rubygame::Surface.new [300, 200]
      @background.fill :red
      
    end
    
    def update
      @entities.each { |id,e| e.update }
    end
    
    def draw
      @background.blit surface, [250, 250]
      @entities.each { |id,e| e.draw }
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