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

      #how many tiles is the map
      @world_width = @area[0].length * TILE_WIDTH
      @world_height = @area.length * TILE_HEIGHT

      #how many tiles will fit on screen
      @screen_tiles_width = SCREEN_WIDTH / TILE_WIDTH
      @screen_tiles_height = SCREEN_HEIGHT / TILE_HEIGHT

      #where is the world camera at
      @last_camera_pos = [-1,-1]

      @background = Rubygame::Surface.new [SCREEN_WIDTH, SCREEN_HEIGHT]


      @tiles = Rubygame::Surface.load "./resource/img/tiles.png"
      @rect_tile = Rubygame::Rect.new 0, 0, TILE_WIDTH, TILE_HEIGHT 



      @ran = false

      puts "world WxH #{@world_width},#{@world_height}"
    end
    
    def get_tile(x, y)

      begin
        tile_no = @area[x][y]
      rescue
        tile_no = 0
      end

      return tile_no
    end
    
    def get_blit_rect(tile_no, tx, ty, rect)
        puts "tile_no #{tile_no} tx #{tx} ty#{ty} "
        rect.left = 0
        rect.right = TILE_WIDTH
        rect.top = tile_no * TILE_HEIGHT
        rect.bottom = rect.top + TILE_HEIGHT


        #if tx < 0 then
        #    rect.left = rect.left - tx
        #    tx = 0
        #end
        #if ty < 0 then
        #    rect.top = rect.top - ty
        #    ty = 0
        #end


        #should be clipping to
        #if tx + TILE_WIDTH > SCREEN_WIDTH then
        #  rect.right = rect.right + (SCREEN_WIDTH - (tx + TILE_WIDTH))

        #end
        #if ty + TILE_HEIGHT > SCREEN_HEIGHT then
        #  rect.bottom = rect.bottom + (SCREEN_HEIGHT - (ty + TILE_HEIGHT))
        #end


    end
    
    def blit_tiles(camera_pos)
      #Algorithmn at  http://www.cpp-home.com/tutorials/292_1.htm

      #converts camera to be a top_left point
      world_point = [camera_pos[0] - (SCREEN_WIDTH / 2),camera_pos[1] - (SCREEN_HEIGHT / 2)]

      #Create the Screen from left to right, top to bottom
      y, x = 0, 0
      @background.fill([0,0,0])

      @screen_tiles_height.to_int.times do
        
        @screen_tiles_width.to_int.times do
             scroll_x = x + (world_point[0] / TILE_WIDTH)
             scroll_y = y + (world_point[1] / TILE_HEIGHT)

             #Use Bitwise AND to get finer offset
             offset_x = world_point[0] & (TILE_WIDTH - 1)
             offset_y = world_point[1] & (TILE_HEIGHT - 1)

             tile_num = get_tile scroll_y,scroll_x

             get_blit_rect tile_num,scroll_x,scroll_y,@rect_tile

             #puts "row=#{y} col=#{x} tile_num#{tile_num}"

             @tiles.blit @background, [(x * TILE_WIDTH) - offset_x,(y * TILE_HEIGHT) - offset_y], @rect_tile

            x = x + 1
        end
        x = 0
        y = y + 1
      end

      #update the world camera
      @last_camera_pos = [camera_pos[0],camera_pos[1]]
    end

    def camera_moved?(camera_pos)
      #puts "last_cx #{@last_cx},last_cy #{@last_cy}"
      if @last_camera_pos[0] != camera_pos[0] or @last_camera_pos[1] != camera_pos[1] then
        return true
      end
      return false
    end
    
    def draw(screen, camera_pos)

      #dont re-blit if the camera hasnt moved... blit_tiles is expensive
      if camera_moved? camera_pos then
        #puts "Camera moved xy=>#{cx},#{cy}"
          blit_tiles camera_pos
      end
      @background.blit screen, [0, 0]
    end

    def full_size
      return [@area.length * TILE_WIDTH,@area[0].length * TILE_HEIGHT]
    end
  end
  
end