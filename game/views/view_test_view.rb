require "game/views/hud_view.rb"
require "game/views/modal_view.rb"

module Game::Views

  class ViewTestView < Game::Core::View
    
    def initialize
      super
    end
    
    def loading
      @menu = Game::Core::Menu.new [0, 0], [300, 200], 25, [255,255,255], 14
      @menu.add_item "Add Hud", method(:menu_add_hud_selected)
      @menu.add_item "Show Hud", method(:menu_show_hud_selected)
      @menu.add_item "Hide Hud", method(:menu_hide_hud_selected)
      @menu.add_item "Close Hud", method(:menu_close_hud_selected)
      @menu.add_item "Show Modal View", method(:menu_show_modal_selected)
      @menu.add_item "Cancel Exit Event", method(:menu_fake_exit_selected)
      @menu.add_item "Exit", method(:menu_exit_selected)
      @menu.select_by_index 0
      
      @hud = HudView.new
      
      @modal_dialog = ModalView.new
      add_view @modal_dialog
    end
    
    def update(clock)
      @menu.update clock
    end
    
    def draw(surface)
      @menu.draw surface
    end
    
    def menu_add_hud_selected
      add_view @hud
    end
    
    def menu_show_hud_selected
      @hud.show
    end
    
    def menu_hide_hud_selected
      @hud.hide
    end
    
    def menu_close_hud_selected
      @hud.close
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
      @modal_dialog.show
      freeze
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
