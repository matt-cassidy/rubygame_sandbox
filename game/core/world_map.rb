require "rubygame"
require "game/core/layer.rb"

module Game::Core

  class WorldMap
    
    attr_reader :area
    


    def initialize(screen_width = 640,screen_height = 480)
      @layers =[[],[],[],[],[]]

      #where is the world camera at
      @last_camera_pos = [-1,-1]

      @screen_width = screen_width
      @screen_height = screen_height

      @background = Rubygame::Surface.new [@screen_width, @screen_height]

      @input = Game::Core::PlayerInput
    end

    def blit_layers (clock, camera_pos)
      @background.fill([0,0,0])

      for layer_group in (@layers)
          layer_group.each { |e|
              if e.visible == true then

                e.update clock, camera_pos,@background
              end
            }
       end

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
      camera_top_left = [camera_pos[0] - (@screen_width / 2),camera_pos[1] - (@screen_height / 2)]

      changed = handle_layers

      #dont re-blit if the camera hasnt moved... blit_tiles is expensive
      if camera_moved? camera_top_left || changed then
        blit_layers clock, camera_top_left
      end

    end

    def handle_layers
      changed = false

      #there must be a better way that this
      if @input.key_pressed?( :number_1 ) then
          changed = true
          @layers[0].each { |e|
              e.visible = !e.visible
          }
      end

      if @input.key_pressed?( :number_2 ) then
          changed = true
          @layers[1].each { |e|
              e.visible = !e.visible
          }
      end

      if @input.key_pressed?( :number_3 ) then
          changed = true
          @layers[2].each { |e|
              e.visible = !e.visible
          }
      end

      if @input.key_pressed?( :number_4 ) then
          changed = true
          @layers[3].each { |e|
              e.visible = !e.visible
          }
      end

      return changed

    end

    def draw(screen)
      #blit the background to the screen surface
      @background.blit screen, [0, 0]
    end

    def add_layer(layer)

      @layers[layer.layer_num] << layer

    end

  end
  
end