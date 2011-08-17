require "game/core/layer.rb"

module Game::Core

  class ParallaxLayer < Game::Core::Layer
    def initialize (area,tiles,tile_width,tile_height,pos)
      super area,tiles,tile_width,tile_height
      @pos = pos
    end

    def blit_layer(camera_pos,background)

      #Create the Screen from left to right, top to bottom

      #TODO: properly clip tile for efficiency
      blit_pos = start_blit_pos @pos[0],@tile_width
      @pos[0] = blit_pos

      x = 0
      y = 0
      @screen_tiles_width.to_int.times do


        tile_num = get_tile x,y,camera_pos

        get_blit_rect tile_num,@rect_tile

        @tiles.blit background,[blit_pos,@pos[1]],@rect_tile
        blit_pos += @tile_width
        x += 1
      end

    end



  end



end