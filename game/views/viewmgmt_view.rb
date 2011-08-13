require "game/views/hud_view.rb"
require "game/views/modal_view.rb"
require "game/views/transparency_view.rb" 
require "game/views/alpha_comp_view.rb" 

module Game::Views

  class ViewMgmtView < Game::Core::View
    
    def initialize(parent)
      super parent
    end
    
    def loading
      @menu = Game::Entities::Menu.new self, [50, 50], [300, 200], 25, [255,255,255], 14
      add_entity @menu
      
      @menu.add_item "Show Hud", method(:menu_show_hud_selected)
      @menu.add_item "Hide Hud", method(:menu_hide_hud_selected)
      @menu.add_item "Show Modal View", method(:menu_show_modal_selected)
      @menu.add_item "Alpha Compositing", method(:menu_alpha_selected)
      @menu.add_item "Transparency", method(:menu_transparency_selected)
      @menu.add_item "Cancel Exit Event", method(:menu_fake_exit_selected)
      @menu.add_item "Exit", method(:menu_exit_selected)
      @menu.select_by_index 0
      
      @hud = HudView.new self
      add_view @hud
      
      @alpha = AlphaCompView.new self
      add_view @alpha
      
      @trans = TransparencyView.new self
      add_view @trans
      
      @dialog = ModalView.new self
      add_view @dialog
      
    end
    
    def menu_show_hud_selected
      @hud.show
    end
    
    def menu_hide_hud_selected
      @hud.hide
    end
    
    def menu_exit_selected
      @cancel_exit = false
      close
    end
    
    def menu_fake_exit_selected
      @cancel_exit = true
      close
    end
    
    def menu_show_modal_selected
      @dialog.show
      deactivate
    end
    
    def menu_transparency_selected
      if @trans.visible? then
        @trans.hide
      else
        @trans.show
      end
    end
    
    def menu_alpha_selected
      if @alpha.visible? then
        @alpha.hide
      else
        @alpha.show
      end
    end
    
    def closing
      if @cancel_exit then
        puts "Exit was canceled"
        return true
      else
        quit
      end
    end

  end
    
end
