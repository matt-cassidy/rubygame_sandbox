
module Game::Views

  class ModalView < Game::Core::View
    
    def initialize(parent)
      super parent
    end
    
    def load
      @menu = Game::Entities::Menu.new self, [100, 100], [100, 50], 25, [255,255,255], 14
      add_entity @menu
      
      @menu.add_item "Ok", method(:menu_nothing_selected)
      @menu.add_item "Close", method(:menu_close_selected)
      @menu.select_by_index 0
      @background = Rubygame::Surface.new [300, 200]
      @background.fill :red
      
    end
    
    def update
      @entities.each { |id,e| e.update }
    end
    
    def draw
      @entities.each { |id,e| e.draw }
      @background.blit surface, [250, 250]
    end
    
    def menu_close_selected
      hide
      @parent.unfreeze
    end
    
    def menu_nothing_selected
      hide
      @parent.unfreeze
    end
   
   end
    
end