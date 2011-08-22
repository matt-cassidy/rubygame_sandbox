require "game/core/timer"
require "game/entities/menu_item"

module Game::Entities
  
  class Menu < Game::Core::Entity
    
    MENU_SELECT_SPEED = 0.15 #make sure player cannot change selection than x times per sec
    MENU_TRIGGER_SPEED = 0.5 #make sure player cannot trigger more than x times per sec
    
    attr_reader :menu_items
    attr_reader :item_height
    attr_reader :buffer
    attr_reader :selected_index
    attr_reader :font_color
    attr_reader :font_size
    attr_reader :disabled
    
    def initialize(view, pos, menu_size, item_height, font_color, font_size)
      super view, pos
      @timer = Game::Core::Timer.new
      @font_color = font_color
      @font_size = font_size
      @item_size = [menu_size[0],item_height]
      @item_height = item_height
      @menu_size = menu_size
      @items = []
      @buffer = Rubygame::Surface.new menu_size
      @selected_item = nil
      @input = Game::Core::PlayerInput
    end
    
    def update
      super
      @timer.cool_down @view.clock.seconds
      if(@input.down?( :return )) 
        trigger
      elsif(@input.down?( :down )) 
        select_next       
      elsif(@input.down?( :up )) 
        select_prev
      end
    end
    
    def select_next
      current_index = @items.index @selected_item
      if(current_index + 1 > @items.size - 1)
        select_by_index 0
      else
        select_by_index current_index + 1
      end
    end
    
    def select_prev
      current_index = @items.index @selected_item
      if(current_index - 1 < 0)
        select_by_index @items.size - 1
      else
        select_by_index current_index - 1
      end
    end
    
    def select_by_index(index)
      return if not @timer.done?
      
      if not @selected_item.nil? then
        @selected_item.unselect
      end
      @selected_item = @items[index]
      @selected_item.select
      
      @timer.wait_for MENU_SELECT_SPEED
    end
    
    def trigger
      return if not @timer.done?
      if not @selected_item.nil? then
        @selected_item.trigger
      end
      @timer.wait_for MENU_TRIGGER_SPEED
    end
    
    def draw
      super
      @items.each do |item| 
        index = @items.index item
        y = index * @item_size[1] + pos.y
        blit item, [pos.x, y]
      end
    end
    
    def add_item(text, callback)
      item = MenuItem.new text, @font_size, @item_size, callback
      @items << item
    end
    
  end
  
end