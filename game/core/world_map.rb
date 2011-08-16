require "rubygame"
require "game/core/layer.rb"

module Game::Core

  class WorldMap
    
    attr_reader :area
    
    SCREEN_WIDTH = 640
    SCREEN_HEIGHT = 480
    TILE_WIDTH = 64
    TILE_HEIGHT = 64

    def initialize
      @area = eval File.open("./resource/area/test.area").read
      @layers = []

      # what are the dimensions of the map loaded
      @world_width = @area[0].length * TILE_WIDTH
      @world_height = @area.length * TILE_HEIGHT

      #how many tiles will fit on screen
      #TODO: hack for tile clipping
      @screen_tiles_width = SCREEN_WIDTH / TILE_WIDTH + 1
      @screen_tiles_height = SCREEN_HEIGHT / TILE_HEIGHT + 2

      #where is the world camera at
      @last_camera_pos = [-1,-1]

      @background = Rubygame::Surface.new [SCREEN_WIDTH, SCREEN_HEIGHT]

      @tiles = Rubygame::Surface.load "./resource/img/tiles.png"
      @rect_tile = Rubygame::Rect.new 0, 0, TILE_WIDTH, TILE_HEIGHT 

    end
    
    def get_tile(x,y,camera_pos)
       map_pos = [x + (camera_pos[0] / TILE_WIDTH),y + (camera_pos[1] / TILE_HEIGHT)]

       begin
        tile_no = @area[map_pos[0]][map_pos[1]]
      rescue
        tile_no = 5
      end

      return 5 if tile_no.nil?
      return tile_no
    end
    
    def get_blit_rect(tile_no, offset_x, offset_y, rect)
        rect.left = 0
        rect.right = TILE_WIDTH
        rect.top = tile_no * TILE_HEIGHT
        rect.bottom = rect.top + TILE_HEIGHT

        #this following section should be doing the clipping to display partial tiles

        #if the tile's right side is off the screen clip(shrink the rectangle's right to fit screen) it
        if (offset_x + TILE_WIDTH) > SCREEN_WIDTH then
          #puts "clipping right"
          #rect.right= rect.right - ((x * TILE_WIDTH + TILE_WIDTH) - SCREEN_WIDTH)
        end

        #if the tile's bottom is off the screen clip (shrink the rectangle's bottom to fit screen) it
        if (offset_y + TILE_HEIGHT) > SCREEN_HEIGHT then
          #puts "clipping bottom"
          #rect.bottom= rect.bottom - ((y * TILE_HEIGHT + TILE_HEIGHT) - SCREEN_HEIGHT)
        end
    end
    
    def blit_tiles(camera_pos)
      #Algorithmn at  http://www.cpp-home.com/tutorials/292_1.htm

      #Create the Screen from left to right, top to bottom
      y, x = 0, 0

      @screen_tiles_height.to_int.times do
        
        @screen_tiles_width.to_int.times do
             #Use Bitwise AND to get finer offset
             #If you remove the -1 you get tile by tile moving as the offset is always 0,0
             offset_x = (x * TILE_WIDTH) - (camera_pos[0] & (TILE_WIDTH - 1))
             offset_y = (y * TILE_HEIGHT) - (camera_pos[1] & (TILE_HEIGHT - 1))
             tile_num = get_tile x,y,camera_pos

             get_blit_rect tile_num,offset_x,offset_y,@rect_tile

             @tiles.blit @background, [offset_x,offset_y], @rect_tile

            x = x + 1
        end
        x = 0
        y = y + 1
      end

      #update the world camera
      @last_camera_pos = [camera_pos[0],camera_pos[1]]
    end

    def camera_moved?(camera_pos)
      if @last_camera_pos[0] != camera_pos[0] or @last_camera_pos[1] != camera_pos[1] then
        return true
      end
      return false
    end

    def update(clock,camera_pos)
      #convert camera position to use top left instead of centre position
      camera_top_left = [camera_pos[0] - (SCREEN_WIDTH / 2),camera_pos[1] - (SCREEN_HEIGHT / 2)]

      #dont re-blit if the camera hasnt moved... blit_tiles is expensive
      if camera_moved? camera_top_left then
        blit_tiles camera_top_left
      end

    end

    def draw(screen)
      #blit the background to the screen surface
      @background.blit screen, [0, 0]
    end

    def add_layer(layer)

    end

    def remove_layer(layer_num)

    end


  end
  
end