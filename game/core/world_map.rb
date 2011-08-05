require "rubygame"

module Game::Core

  class WorldMap
    
    attr_reader :area
    
    SCREEN_WIDTH = 640
    SCREEN_HEIGHT = 480
    TILE_WIDTH = 64
    TILE_HEIGHT = 64

    def initialize
      @area = eval File.open("./resource/area/test.area").read
      @background = Rubygame::Surface.new [SCREEN_WIDTH, SCREEN_HEIGHT]
      @tiles = Rubygame::Surface.load "./resource/img/tiles.png"
      @rect_tile = Rubygame::Rect.new 0, 0, TILE_WIDTH, TILE_HEIGHT 
      @tiles_width = SCREEN_WIDTH / TILE_WIDTH
      @tiles_height = SCREEN_HEIGHT / TILE_HEIGHT
      @last_cx = -1
      @last_cy = -1
    end
    
    def get_tile(tx, ty, cx, cy)
      x = (tx + TILE_WIDTH / 2 + cx - SCREEN_WIDTH / 2) / TILE_WIDTH
      y = (ty + TILE_HEIGHT / 2 + cy - SCREEN_HEIGHT / 2) / TILE_HEIGHT
      
      tile_no = @area[x][y]
      
      #puts "xy=#{x},#{y} => #{tile_no}"
      
      return 0 if tile_no.nil?
      return tile_no
    end
    
    def get_blit_rect(tile_no, tx, ty, rect)
        rect.left = 0
        rect.right = TILE_WIDTH
        rect.top = tile_no * TILE_HEIGHT
        rect.bottom = rect.top + TILE_HEIGHT
 
        if tx < 0 then
            rect.left = rect.left - tx
            tx = 0
        end
        if ty < 0 then
            rect.top = rect.top - ty
            ty = 0
        end
        
        if tx + TILE_WIDTH > SCREEN_WIDTH then 
          rect.right = rect.right + (SCREEN_WIDTH - (tx + TILE_WIDTH))
        end
        if ty + TILE_HEIGHT > SCREEN_HEIGHT then 
          rect.bottom = rect.bottom + (SCREEN_HEIGHT - (ty + TILE_HEIGHT))
        end
   
    end
    
    def blit_tiles(cx, cy)
      i, j = 0, 0
      
      
      @tiles_width.to_int.times do
        
        @tiles_height.to_int.times do
            tx = i * TILE_WIDTH - cx % TILE_WIDTH
            ty = j * TILE_HEIGHT - cy % TILE_HEIGHT
            tile_num = get_tile tx, ty, cx, cy
            get_blit_rect tile_num, tx, ty, @rect_tile
            @tiles.blit @background, [tx, ty], @rect_tile
            j = j + 1
        end
        j = 0
        i = i + 1
      end
      @last_cx = cx
      @last_cy = cy
    end
    
    def camera_moved?(cx, cy)
      return true if @last_cx != cx or @last_cy != cy
      return false
    end
    
    def draw(screen, cx, cy)
      #dont re-blit if the camera hasnt moved... blit_tiles is expensive
      if camera_moved? cx, cy then
        blit_tiles cx, cy
      end
      @background.blit screen, [0, 0]
    end
    
  end
  
end