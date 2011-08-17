require "game/core/layer.rb"

module Game::Core

  class ParallaxLayer < Game::Core::Layer
    def initialize (area,tiles,tile_width,tile_height)
      super area,tiles,tile_width,tile_height
    end

    def blit_layer(camera_pos,background)

        #Create the Screen from left to right, top to bottom


      @pos[0] = start_blit_pos @pos[0],@tile_width


        x = 0
        y = 0
        @screen_tiles_width.to_int.times do
          map_pos = [x + (camera_pos[0] / @tile_width),y + (camera_pos[1] / @tile_height)]

          tile_num = get_tile map_pos,camera_pos #works
          get_blit_rect tile_num,@rect_tile  #works


          #offset_x = (x * @tile_width) -  (camera_pos[0] & (@tile_width - 1))
          #offset_y = (y * @tile_height) - (camera_pos[1] & (@tile_height - 1))

          #@tiles.blit background, [offset_x + @displacement[0],@pos[1] + @displacement[1]], @rect_tile


          @tiles.blit background,[@pos[0] + (x * @tile_width),@pos[1]],@rect_tile #works

          x += 1
        end

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