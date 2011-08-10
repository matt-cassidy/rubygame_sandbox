require "game/views/test_view.rb"
require "game/core/text_box.rb"
require "game/core/player_input.rb"

module Game::Views

  class MenuView < Game::Core::View
    
    def initialize
      super
    end
    
    def loading
      @menu = Menu.new [0, 0], [200, 200], 25, [255,255,255], 14
      @menu.add_item "Start", method(:menu_start_selected)
      @menu.add_item "Exit", method(:menu_exit_selected)
      @menu.select_by_index 0
      
      @input = Game::Core::PlayerInput.new

    end
    
    def update_screen(seconds, clock)
      
      @input.fetch

      if(@input.key_pressed?( :return )) 
        puts "asdsfasfasfasfafasf"
        @menu.trigger
      
      elsif(@input.key_pressed?( :down )) 
        @menu.select_next
        
      elsif(@input.key_pressed?( :up )) 
        @menu.select_prev
        
      end
      
    end
    
    def draw(surface)
      @menu.draw surface
    end
    
    def menu_exit_selected
      throw :quit
    end
    
    def menu_start_selected
      puts "hi"
      @view_manager.add_view TestView.new
      close
    end
    
  end
  
  class Menu < Game::Core::GameObject
    
    MENU_SELECT_SPEED = 6 #player can change the selected menu item every number of frames
    MENU_TRIGGER_SPEED = 10 #player can change the selected menu item every number of frames
    
    attr_reader :menu_items
    attr_reader :item_height
    attr_reader :buffer
    attr_reader :selected_index
    attr_reader :font_color
    attr_reader :font_size
    
    def initialize(pos, menu_size, item_height, font_color, font_size)
      super pos
      @font_color = font_color
      @font_size = font_size
      @item_size = [menu_size[0],item_height]
      @item_height = item_height
      @menu_size = menu_size
      @menu_items = []
      @buffer = Rubygame::Surface.new menu_size
      @selected_item = nil
      @cool_down_counter = 0
    end
    
    def cool_down
      @cool_down_counter = @cool_down_counter - 1
    end
    
    def cool_up speed
      @cool_down_counter = speed
    end
    
    def cooled_down?
      cool_down
      return true if @cool_down_counter <= 0
    end
    
    def select_next
      current_index = @menu_items.index @selected_item
      if(current_index + 1 > @menu_items.size - 1)
        select_by_index 0
      else
        select_by_index current_index + 1
      end
    end
    
    def select_prev
      current_index = @menu_items.index @selected_item
      if(current_index - 1 < 0)
        select_by_index @menu_items.size - 1
      else
        select_by_index current_index - 1
      end
    end
    
    def select_by_index(index)
      return if not cooled_down? 
      if not @selected_item.nil? then
        @selected_item.unselect
      end
      @selected_item = @menu_items[index]
      @selected_item.select
      cool_up MENU_SELECT_SPEED
    end
    
    def trigger
      puts "cooled_down? #{cooled_down?}"
      return if not cooled_down? 
      if not @selected_item.nil? then
        @selected_item.trigger
      end
      cool_up MENU_TRIGGER_SPEED
    end
    
    def draw(surface)
      @buffer.fill(:black)
      @menu_items.each {|item| item.draw @buffer }
      @buffer.blit surface, pos
    end
    
    def add_item(text, block)
      item_y = @item_height * (@menu_items.size)
      item = MenuItem.new [0, item_y], @item_size, text, @font_size, @font_color, block
      @menu_items << item
      if @selected_item.nil? then
        @selected_item = item
      end
    end
    
  end
  
  class MenuItem < Game::Core::GameObject
    
    attr_reader :selected
    attr_reader :textbox
    attr_reader :rect
    
    def initialize(pos, rect_size, text, font_size, font_color, click_callback)
      super pos
      @selected = false
      @textbox = Game::Core::TextBox.new pos, text, font_size, font_color
      @textbox.text = text
      @image = Rubygame::Surface.new(rect_size)
      @image.fill([100, 100, 100])
      @image.set_alpha 0
      @click_callback = click_callback
    end
    
    def select
      @selected = true
      @image.set_alpha 255
    end
    
    def unselect
      @selected = false
      @image.set_alpha 0
    end
    
    def text=(value)
      @textbox.text = value
    end
    
    def draw(surface)
      @image.blit surface, pos
      @textbox.draw surface
    end
    
    def trigger
      @click_callback.call
    end
    
  end  
  
end