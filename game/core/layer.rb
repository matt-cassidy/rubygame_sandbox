
module Game::Core

  class Layer

    attr_reader :tile_width
    attr_reader :tile_height
    attr_reader :name
    attr_reader :entity_id

    attr_accessor :layer_no
    attr_accessor :visible
    attr_accessor :pos

    def initialize (area,tiles,tile_width,tile_height,properties = {})
      @name = tiles
      @entity_id = GOID.next

      @tile_width = tile_width
      @tile_height = tile_height

      @visible = true

      @layer_no = 0

      @speed = [150,150]

      @pos = [0,0]

      @tiles = Rubygame::Surface.load "./resource/img/#{tiles}.png"
      @rect_tile = Rubygame::Rect.new 0, 0, @tile_width, @tile_height

      if (!area.nil?) then
        if area.kind_of?(Array) then
          @area = area
        else
          @area = eval File.open("./resource/area/#{area}.area").read
        end
       else
         @area = [[0]]
       end



      @last_camera = [0,0]

      # what are the dimensions of the map loaded
      @world_width = @area[0].length
      @world_height = @area.length

      @screen_tiles_height = 0
      @screen_tiles_width = 0

      @desired_tiles_amount_width = nil
      @desired_tiles_amount__height = nil

      @repeat_x = true
      @repeat_y = true


      @layer_no = properties["layer_no"]  if properties["layer_no"]
      @repeat_x = false  if properties["repeat_x"] == 0
      @repeat_y = false if properties["repeat_y"] == 0
      @pos = properties["pos"]  if properties["pos"]
      @speed = properties["speed"]  if properties["speed"]

    end

    def setup_layer (tiles_width_amount,tiles_height_amount,speed, pos = nil)
      if tiles_width_amount != nil
         if tiles_width_amount == 1
           @repeat_x = false
         end
       end

       if tiles_height_amount != nil
         if tiles_height_amount == 1
           @repeat_y = false
         end
       end

       @desired_tiles_amount__width = tiles_width_amount
       @desired_tiles_amount__height = tiles_height_amount
       
       @speed = speed

       @pos = pos if pos.nil? == false
    end

    def setup_background(background)
      temp_width_amount = amount_of_tiles @tile_width,background.width
      temp_height_amount = amount_of_tiles @tile_height, background.height


      if @repeat_x
        @screen_tiles_width = temp_width_amount
      else
        @screen_tiles_width = 1
      end

      if @repeat_y
         @screen_tiles_height =  temp_height_amount
      else
         @screen_tiles_height = 1
      end

      #
      #if @desired_tiles_amount__width.nil? == true || @desired_tiles_amount__width > temp_width_amount
      #  @screen_tiles_width = temp_width_amount
      #else
      #  @screen_tiles_width = @desired_tiles_amount__width
      #end

      #if @desired_tiles_amount__height.nil? == true || @desired_tiles_amount__height > temp_height_amount
      #  @screen_tiles_height =  temp_height_amount
      #else
      #  @screen_tiles_height = @desired_tiles_amount__height
      #end

    end


    def amount_of_tiles (increase_by,till)
      #calculates the amount of times a value
      a = 0 - increase_by/4
      need = 0
      while  a < (till + increase_by )
        need += 1
        a += increase_by
      end

      return need
    end

    def update(clock,camera_pos,background)
      handle_displacement clock,camera_pos

      if @repeat_x == true
        @pos[0] = start_blit_pos @pos[0],@tile_width
      end


      if @repeat_y == true
         @pos[1] = start_blit_pos @pos[1],@tile_height
      end

      blit_layer camera_pos,background

      @last_camera = [camera_pos[0],camera_pos[1]]
    end

    def handle_displacement clock,camera_pos
      @displacement_x = 0
      @displacement_y = 0

      if @last_camera[0] < camera_pos[0] #moving forward
        @displacement_x = (@speed[0] * clock.seconds)
      elsif @last_camera[0] > camera_pos[0] #moving backward
        @displacement_x = (@speed[0] * clock.seconds) * -1
      end
      @pos[0] -= @displacement_x

      if @last_camera[1] < camera_pos[1] #moving up
        @displacement_y = (@speed[1] * clock.seconds)
      elsif @last_camera[1] > camera_pos[1] #moving down
        @displacement_y = (@speed[1] * clock.seconds) * -1
      end
      @pos[1] -= @displacement_y

    end

    def blit_layer(camera_pos,background)
      #Algorithmn at  http://www.cpp-home.com/tutorials/292_1.htm

      #Create the Screen from left to right, top to bottom
      y, x = 0, 0

      @screen_tiles_height.to_int.times do

        @screen_tiles_width.to_int.times do

             map_pos = [x + (camera_pos[0] / @tile_width),y + (camera_pos[1] / @tile_height)]

             #Use Bitwise AND to get finer offset
             #If you remove the -1 you get tile by tile moving as the offset is always 0,0
             offset_x = (x * @tile_width) -  (camera_pos[0].to_int & (@tile_width - 1) )
             offset_y = (y * @tile_height) - (camera_pos[1].to_int & (@tile_height - 1))

             tile_num = get_tile map_pos
             get_blit_rect tile_num,@rect_tile

             @tiles.blit background, [offset_x,offset_y], @rect_tile

            x = x + 1
        end
        x = 0
        y = y + 1
      end

    end

    def get_tile(map_pos)
        #this section creates the effect of an infinite world (aka xy treadmill like scrolling)
         if map_pos[0] < -@world_width then
           map_pos[0] = -@world_width + (map_pos[0] % @world_width)
         end

         if map_pos[0] >= @world_width then
           map_pos[0] = (map_pos[0] % @world_width)
         end


         if map_pos[1] <= -@world_height then
           map_pos[1] = -@world_height + (map_pos[1] % @world_height)
         end

         if map_pos[1] >= @world_height then
           map_pos[1] = (map_pos[1] % @world_height)
         end

       begin
        #you swap them otherwise the map is flipped 90 degrees counter clockwise
        tile_no = @area[map_pos[1]][map_pos[0]]
      rescue
        puts "get_tile - rescued xy #{map_pos[1]},#{map_pos[0]}"
        tile_no = 0
      end

      if tile_no.nil? then
        puts "get_tile - tile_no nill xy #{map_pos[1]},#{map_pos[0]}"
        return 0
      end

      return tile_no
    end

    def get_blit_rect(tile_no, rect)
        #TODO: properly clip tile for efficiency
        if tile_no.kind_of?(Array)
           rect.left = tile_no[1] * @tile_width
           rect.top = tile_no[0] * @tile_height
        else
          rect.left = 0
          rect.top = tile_no * @tile_height
        end


        rect.right = rect.left + @tile_width
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

    def world_dimensions?
        return [@world_width * @tile_width,@world_height * @tile_height]
    end
  end

end