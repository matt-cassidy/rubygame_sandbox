require "game/core/layer.rb"

module Game::Core

  class ParallaxLayer < Game::Core::Layer
    def initialize (tiles,tile_width,tile_height,pos,speed,layer_num = 0)
      super nil,tiles,tile_width,tile_height,layer_num

      @pos = pos
      @speed = speed
      @last_camera = [0,0]
    end

    def update(clock,camera_pos,background)

      distance_x = (@speed[0] * clock.seconds).round
      distance_y = (@speed[1] * clock.seconds).round
      if @last_camera[0] < camera_pos[0] #moving forward
        @pos[0] += distance_x
      elsif @last_camera[0] > camera_pos[0] #moving backward
        @pos[0] -= distance_x
      end

      if @last_camera[1] < camera_pos[1] #moving forward
        @pos[1] += distance_y
      elsif @last_camera[1] > camera_pos[1] #moving backward
        @pos[1] -= distance_y
      end


      blit_layer camera_pos,background

      @last_camera = [camera_pos[0],camera_pos[1]]
    end


    def blit_layer(camera_pos,background)
      #Create the Screen from left to right, top to bottom

      #TODO: properly clip tile for efficiency
      if @pos[0].abs >= @tile_width
        @pos[0] = 0
      end

      if (@pos[0] - @tile_width) < background.width
        location = [@pos[0] + @tile_width, @pos[1]]
        @tiles.blit background,location
      end

       if (@pos[0] + @tile_width) > background.width
        location = [@pos[0] - @tile_width, @pos[1]]
        @tiles.blit background,location
      end


      @tiles.blit background, @pos

    end

  end



end