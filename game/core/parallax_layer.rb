require "game/core/layer.rb"

module Game::Core

  class ParallaxLayer < Game::Core::Layer
    def initialize (area,tiles,tile_width,tile_height,properties = {})
      super area,tiles,tile_width,tile_height,properties
    end

   def blit_layer(camera_pos,background)


        #Create the Screen from left to right, top to bottom

        x = 0
        y = 0
        @screen_tiles_height.to_int.times do
          @screen_tiles_width.to_int.times do
            map_pos = [x + (camera_pos[0] / @tile_width),y + (camera_pos[1] / @tile_height)]

            tile_num = get_tile map_pos#,camera_pos #works
            get_blit_rect tile_num,@rect_tile  #works


            #puts "name:#{@name} camera pos x #{camera_pos[0]} pos x #{@pos[0]} camera pos y #{camera_pos[1]} pos y #{@pos[1]} "
            offset_x = ((x * @tile_width) +  @pos[0] ) # - (camera_pos[0] & @tile_width - 1)
            offset_y = ((y * @tile_height) + @pos[1] ) # - (camera_pos[1] & @tile_height - 1)

            @tiles.blit background,[offset_x,offset_y],@rect_tile #works
            #puts
            x += 1
          end
          x= 0
          y += 1
        end
   end


  end



end