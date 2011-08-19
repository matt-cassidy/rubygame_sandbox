require "game/core/hex_rgb.rb"

include Game::Core::Hex_Convert

module Game::Core

  class Layer

    attr_reader :tile_width
    attr_reader :tile_height
    attr_reader :name
    attr_reader :entity_id
    attr_reader :layer_no
    attr_reader :pos

    attr_accessor :visible
    attr_accessor :config

    def initialize (area,tiles,tile_width,tile_height,properties = {})
      @name = tiles
      @entity_id = GOID.next

      if properties.has_key? "layer_no"  then @layer_no = properties["layer_no"]  else @layer_no =0      end
      if properties.has_key? "repeat_x"  then @repeat_x = properties["repeat_x"]  else @repeat_x = true  end
      if properties.has_key? "repeat_y"  then @repeat_y = properties["repeat_y"]  else @repeat_y = true  end
      if properties.has_key? "pos"       then @pos = properties["pos"]            else @pos = [0,0]      end
      if properties.has_key? "speed"     then @speed = properties["speed"]        else @speed = [150,150] end
      if properties.has_key? "visible"   then @visible = properties["visible"]    else @visible = true    end
      @tile_width = tile_width
      @tile_height = tile_height

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

      @config = nil

      puts "name:#{@name} repeat_y:#{@repeat_y} pos:#{@pos} speed:#{@speed} layer_no:#{@layer_no}"
    end

    def setup_background(background)

      if @repeat_x == true
        @screen_tiles_width = amount_of_tiles_needed @tile_width,background.width
      else
        @screen_tiles_width = 1
      end

      if @repeat_y == true
         @screen_tiles_height =  amount_of_tiles_needed @tile_height, background.height
      else
         @screen_tiles_height = 1
      end


    end


    def amount_of_tiles_needed (increase_by,till)
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
      displacement_x = 0
      displacement_y = 0

      if @last_camera[0] < camera_pos[0] #moving forward
        displacement_x = (@speed[0] * clock.seconds)
      elsif @last_camera[0] > camera_pos[0] #moving backward
        displacement_x = (@speed[0] * clock.seconds) * -1
      end
      @pos[0] -= displacement_x

      if @last_camera[1] < camera_pos[1] #moving up
        displacement_y = (@speed[1] * clock.seconds)
      elsif @last_camera[1] > camera_pos[1] #moving down
        displacement_y = (@speed[1] * clock.seconds) * -1
      end
      @pos[1] -= displacement_y

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

    def whole_layer_to_bmp

    end


    def to_config_file

      puts "getting layer config file"

      if @config.nil? #build config file for this layer at this moment in time
        puts "building layer config file"
        image_location = "./resource/img/#{Time.new.inspect.gsub(/[ \-:]/,"_")}.png"

        puts "building basics"
        config = {
            "name" => "background",
            "image" => image_location,
            "properties" => {
              "layer_no" => @layer_no,
               "repeat_x" => @repeat_x,
               "repeat_y" => @repeat_y,
               "pos" => @pos,
               "visible" => @visible
            },
            "tiles" =>{
                "image" => "./resource/img/#{@name}.png",
                "width" => @tile_width,
                "height" => @tile_height
            }
        }

        puts "building colour definition"
        #calculate amount of tiles in tiles image
        tiles_width = @tiles.width / @tile_width
        tiles_height = @tiles.height / @tile_height
        puts "tile_width:#{tiles_width} tile_height:#{tiles_height}"
        #build the colour definition
        colour_def = Hash.new
        r = 0
        g = 0
        b = 0
        for y in (0..tiles_height - 1)
            for x in (0..tiles_width - 1)
              colour = rgb_to_hex [r % 255,g % 255,b % 255]
              colour_def[colour.to_s] = [x,y]
              r += 10
              g += 15
              b += 5
            end
        end
        config["colour_def"] = colour_def

        puts "building surface"
        world_width =  0
        world_height = @area.length

        #ensures it gets the largest value
        for y in (0..(world_height - 1))
          if @area[y].length > world_width
            world_width = @area[y].length
          end
        end

        surface = Rubygame::Surface.new [world_width,world_height]

        puts "set surface colour"
        for y in (0..(surface.height - 1))
          for x in (0..(surface.width - 1))
              tile_no = get_tile [x,y]

              if tile_no.kind_of?(Array)
                hex = colour_def.key(tile_no)
                colour = hex_to_rgb(hex)

                surface.set_at [x,y],colour
              else
                hex = colour_def.key([0,tile_no])
                colour = hex_to_rgb(hex)
                surface.set_at [x,y],colour
              end


          end
        end
        puts "saving surface"
        surface.savebmp image_location

        @config = config #save the config file to itself
        puts "Ending config"
      end

      return @config
    end


  end

end