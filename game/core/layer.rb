
module Game::Core

  class Layer


    attr_reader :tile_width
    attr_reader :tile_height
    attr_accessor :layer_num
    attr_accessor :visible

    def initialize (area,tiles,tile_width,tile_height,speed,layer_num = 0)
       if (!area.nil?) then
        @area = eval File.open("./resource/area/#{area}.area").read
       else
         @area = [[0]]
       end


       @tile_width = tile_width
       @tile_height = tile_height

       @tiles = Rubygame::Surface.load "./resource/img/#{tiles}.png"
       @rect_tile = Rubygame::Rect.new 0, 0, @tile_width, @tile_height

       # what are the dimensions of the map loaded
       @world_width = @area[0].length #* @tile_width
       @world_height = @area.length  #* @tile_height

       @visible = true
       @speed = speed
       @layer_num = layer_num

       puts "world wXh #{@world_width},#{@world_height}"
    end

    def update(clock,camera_pos,background)
      @screen_tiles_width = background.width / @tile_width + 1
      @screen_tiles_height = background.height / @tile_height + 2

      blit_tiles camera_pos,background
    end

    def blit_tiles(camera_pos,background)

      #Algorithmn at  http://www.cpp-home.com/tutorials/292_1.htm

      #Create the Screen from left to right, top to bottom
      y, x = 0, 0

      @screen_tiles_height.to_int.times do

        @screen_tiles_width.to_int.times do
             #Use Bitwise AND to get finer offset
             #If you remove the -1 you get tile by tile moving as the offset is always 0,0

             offset_x = (x * @tile_width) - (camera_pos[0] & (@tile_width - @speed))
             offset_y = (y * @tile_height) - (camera_pos[1] & (@tile_height - @speed))
             tile_num = get_tile x,y,camera_pos

             get_blit_rect tile_num,offset_x,offset_y,@rect_tile

             @tiles.blit background, [offset_x,offset_y], @rect_tile

            x = x + 1
        end
        x = 0
        y = y + 1
      end

    end

    def get_tile(x,y,camera_pos)
       map_pos = [x + (camera_pos[0] / @tile_width),y + (camera_pos[1] / @tile_height)]

       #this section creates the effect of an infinite world (aka xy treadmill like scrolling)
         if map_pos[0] < -@world_width then
          map_pos[0] = -@world_width + (map_pos[0] % @world_width)
         end

         if map_pos[0] > @world_width then
            map_pos[0] = (map_pos[0] % @world_width)
         end


         if map_pos[1] <= -@world_height then
          map_pos[1] = -@world_height + (map_pos[1] % @world_height)
         end

         if map_pos[1] >= @world_height then
           map_pos[1] = (map_pos[1] % @world_height)
         end


       begin
         #you swap them to otherwise the map is flipped 90degress counter clockwise
        tile_no = @area[map_pos[1]][map_pos[0]]
      rescue
        puts "rescued xy #{map_pos[1]},#{map_pos[0]}"
        tile_no = 0
      end

      return 0 if tile_no.nil?
      return tile_no
    end

    def get_blit_rect(tile_no, offset_x, offset_y, rect)
        rect.left = 0
        rect.right = @tile_width
        rect.top = tile_no * @tile_height
        rect.bottom = rect.top + @tile_height
    end


  end

end