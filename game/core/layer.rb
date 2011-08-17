
module Game::Core

  class Layer


    attr_reader :tile_width
    attr_reader :tile_height
    attr_reader :name

    attr_accessor :layer_num
    attr_accessor :visible
    attr_accessor :speed

    def initialize (area,tiles,tile_width,tile_height)
      @name = tiles
      @tile_width = tile_width
      @tile_height = tile_height


      @tiles = Rubygame::Surface.load "./resource/img/#{tiles}.png"
      @rect_tile = Rubygame::Rect.new 0, 0, @tile_width, @tile_height

      if (!area.nil?) then
        @area = eval File.open("./resource/area/#{area}.area").read
       else
         @area = [[0]]
       end

      @layer_num = 0
      @visible = true
      @speed = [1,1]
      @pos = [0,0]
      @last_camera = [0,0]

      @scroll_x = true
      @scroll_y = true

       # what are the dimensions of the map loaded
       @world_width = @area[0].length
       @world_height = @area.length

       @screen_tiles_height = 0
       @screen_tiles_width = 0

    end

    def setup_blitting_surface (background)

      @screen_tiles_width = amount_of_tiles @tile_width,background.width

      @screen_tiles_height = amount_of_tiles @tile_height, background.height

    end


    def amount_of_tiles (x,z)
      #calculates the amount of times a value
      a = 0 - x/4
      y = 0
      while  a < (z + x )
        y += 1
        a += x
      end

      return y
    end

    def update(clock,camera_pos,background)
      displacement_x = (@speed[0] * clock.seconds)
      displacement_y = (@speed[1] * clock.seconds)


      if @last_camera[0] < camera_pos[0] #moving forward
        @pos[0] += displacement_x
      elsif @last_camera[0] > camera_pos[0] #moving backward
        @pos[0] -= displacement_x
      end

      if @last_camera[1] < camera_pos[1] #moving up
        @pos[1] += displacement_y
      elsif @last_camera[1] > camera_pos[1] #moving down
        @pos[1] -= displacement_y
      end

      puts "pos xy #{@pos[0]},#{@pos[1]}"
      blit_layer camera_pos,background

      @last_camera = [camera_pos[0],camera_pos[1]]
    end

    def blit_layer(camera_pos,background)
      #Algorithmn at  http://www.cpp-home.com/tutorials/292_1.htm

      #Create the Screen from left to right, top to bottom
      y, x = 0, 0

      @screen_tiles_height.to_int.times do

        @screen_tiles_width.to_int.times do
             #Use Bitwise AND to get finer offset
             #If you remove the -1 you get tile by tile moving as the offset is always 0,0

             offset_x = (x * @tile_width) -  (camera_pos[0] & (@tile_width - 1) )
             offset_y = (y * @tile_height) - (camera_pos[1] & (@tile_height - 1))

             tile_num = get_tile x,y,camera_pos

             get_blit_rect tile_num,@rect_tile

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

    def get_blit_rect(tile_no, rect)
        rect.left = 0
        rect.right = @tile_width
        rect.top = tile_no * @tile_height
        rect.bottom = rect.top + @tile_height
    end

    def start_blit_pos (pos,amount)
      return 0 if pos.abs >= amount

      start = pos
      while (start > 0)
        start -= amount
      end
      return start
    end

  end

end