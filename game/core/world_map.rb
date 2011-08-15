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
      @last_camera_pos = [-1,-1]
    end
    
    def get_tile(tx, ty, camera_pos)
      y = (tx + (TILE_WIDTH / 2) + camera_pos[0] - SCREEN_WIDTH / 2) / TILE_WIDTH
      x = (ty + (TILE_HEIGHT / 2) + camera_pos[1] - SCREEN_HEIGHT / 2) / TILE_HEIGHT

      #puts "xy=#{x},#{y}"
      begin
        tile_no = @area[x][y]
      rescue
        tile_no = 4
      end
      
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
    
    def blit_tiles(camera_pos)
      #Create the Screen from left to right, top to bottom
      i, j = 0, 0

      point = full_size
      #puts "Bilt Tiles"
      @tiles_height.to_int.times do
        
        @tiles_width.to_int.times do
            ty = i * TILE_WIDTH - camera_pos[0] % TILE_WIDTH
            tx = j * TILE_HEIGHT - camera_pos[1] % TILE_HEIGHT

            tile_num = get_tile tx, ty, camera_pos
            get_blit_rect tile_num, tx, ty, @rect_tile
            @tiles.blit @background, [tx, ty], @rect_tile
            #puts "i #{i} j#{j} tilenum #{tile_num} tx: #{tx} ty #{ty}"

            j = j + 1
        end
        j = 0
        i = i + 1
      end

      @last_camera_pos = [camera_pos[0],camera_pos[1]]
    end
    
    def camera_moved?(camera_pos)
      #puts "last_cx #{@last_cx},last_cy #{@last_cy}"
      if @last_cx != camera_pos[0] or @last_cy != camera_pos[1] then
        return true
      end
      return false
    end
    
    def draw(screen, camera_pos)

      #dont re-blit if the camera hasnt moved... blit_tiles is expensive
      if camera_moved? camera_pos then
        #puts "Camera moved xy=>#{cx},#{cy}"
        blit_tiles camera_pos
        #@tiles.x = cx
        #@tiles.y = cy
      end
      @background.blit screen, [0, 0]
    end

    def full_size
      return [@area.length * TILE_WIDTH,@area[0].length * TILE_HEIGHT]
    end
  end
  
end