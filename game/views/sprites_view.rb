require "game/core/sprite_sheet_manager"
require "game/core/player_input"

module Game::Views

  class SpritesView < Game::Core::View
    
    def initialize(parent)
      super parent
    end
    
    def loading
      Game::Core::SpriteSheetManager.setup
      @rect = Rubygame::Rect.new 10,10,10,10
      @input = Game::Core::PlayerInput
      @sheet = nil
      @sheet = Game::Core::SpriteSheetManager.load "hero", "0", @rect
    end
    
    def updating
      handle_sprite_viewer_input
    end
    
    def drawing
      @sheet.blit surface, [100, 100], @rect
    end
    
    def handle_sprite_viewer_input
      key = nil
      key = "0" if @input.down? :number_0
      key = "1" if @input.down? :number_1
      key = "2" if @input.down? :number_2
      key = "3" if @input.down? :number_3
      key = "4" if @input.down? :number_4
      key = "5" if @input.down? :number_5
      key = "6" if @input.down? :number_6
      key = "7" if @input.down? :number_7
      key = "8" if @input.down? :number_8
      key = "9" if @input.down? :number_9
      key = "A" if @input.down? :a
      key = "B" if @input.down? :b
      key = "C" if @input.down? :c
      key = "D" if @input.down? :d
      key = "E" if @input.down? :e
      if not key.nil?
        @sheet = Game::Core::SpriteSheetManager.load "hero", key, @rect
      end     
    end
    
   end
    
end








