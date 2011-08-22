require "game/core/sprite_sheet_manager"
require "game/core/player_input"

module Game::Views

  class SpritesView < Game::Core::View
    
    def initialize(parent)
      super parent
    end
    
    def loading
      @sheet_info1 = Game::Core::Font.new "inconsolata", 20
      @sheet_info2 = Game::Core::Font.new "inconsolata", 20
      @frame_info1 = Game::Core::Font.new "inconsolata", 20
      @frame_info3 = Game::Core::Font.new "inconsolata", 20
      @frame_info4 = Game::Core::Font.new "inconsolata", 20
      @controls = Game::Core::Font.new "inconsolata", 16
      @controls.text = "Left/Right = Change Frame,  Up/Down = Change Sheet"
      @rect = Rubygame::Rect.new 10,10,10,10
      @input = Game::Core::PlayerInput
      @sheets = Game::Core::SpriteSheetManager.sheets.keys
      @sindex = 0
      @frames = nil
      @findex = 0
      reset_frames
      update_surface
    end
    
    def updating
      handle_sprite_viewer_input
    end
    
    def drawing
      @surf.blit surface, [280, 240], @rect
      @sheet_info1.blit surface, [10,10]
      @frame_info1.blit surface, [30,40]
      @frame_info3.blit surface, [30,60]
      @frame_info4.blit surface, [30,80]
      @controls.blit surface, [10,450]
    end
    
    def handle_sprite_viewer_input
      next_frame if @input.down? :right
      prev_frame if @input.down? :left
      prev_sheet if @input.down? :up
      next_sheet if @input.down? :down
    end
    
    def update_surface
      update_info
      @surf = Game::Core::SpriteSheetManager.load @sheets[@sindex], @frames[@findex], @rect
    end
    
    def update_info
      @sheet = Game::Core::SpriteSheetManager.sheets[@sheets[@sindex]] 
      @frame = @sheet.frames[@frames[@findex]]
      @sheet_info1.text = "#{@sheet.name}    ( #{@sheet.image} )"
      @frame_info1.text = "ID:    #{@frames[@findex]}"
      @frame_info3.text = "FRAME: #{@frame["frame"]}"
      @frame_info4.text = "FLIP:  #{@frame["flip"]}"
    end
    
    def next_frame
      return if @frames.size <= 1
      if @findex == @frames.size - 1
        @findex = 0
      else
        @findex += 1
      end
      update_surface
    end
    
    def prev_frame
      return if @frames.size <= 1
      if @findex == 0
        @findex = @frames.size - 1
      else
        @findex -= 1
      end
      update_surface
    end
    
    def next_sheet
      return if @sheets.size <= 1
      if @sindex == @sheets.size - 1
        @sindex = 0
      else
        @sindex += 1
      end
      reset_frames
      update_surface
    end
    
    def prev_sheet
      return if @sheets.size <= 1
      if @sindex == 0
        @sindex = @sheets.size - 1
      else
        @sindex -= 1
      end
      reset_frames
      update_surface
    end
    
    def reset_frames
      @findex = 0
      @frames = Game::Core::SpriteSheetManager.sheets[@sheets[@sindex]].frames.keys
    end
    
   end
    
end








