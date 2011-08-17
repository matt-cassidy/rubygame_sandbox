require "rubygame"
require "game/core/layer.rb"
require "game/core/layer_group.rb"

module Game::Core

  class WorldMap
    
    attr_reader :area
    
    def initialize(screen_width = 640,screen_height = 480)

      @layers = [Game::Core::LayerGroup.new(0)]

      #where is the world camera at
      @last_camera_pos = [-1,-1]

      @screen_width = screen_width
      @screen_height = screen_height

      @background = Rubygame::Surface.new [@screen_width, @screen_height]

      @input = Game::Core::PlayerInput
    end

    def blit_layers (clock, camera_pos)
      @background.fill([0,0,0])
      @layers.each { |group|
        if group.visible == true

           group.collection.each { |id,layer|
               layer.update clock, camera_pos,@background
           }
        end
      }

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
      if camera_moved?(camera_top_left) or changed == true then
        blit_layers clock, camera_top_left
      end

    end

    def handle_layers
      changed = false
      keys = [:number_1, :number_2,:number_3,:number_4,:number_5,:number_6,:number_7,:number_8,:number_9,:number_0]


      @layers.each{ | group |
        if @input.up?(keys[group.layer_no]) then
           changed = true
           group.flip
        end
      }

      return changed

    end

    def draw(screen)
      #blit the background to the screen surface
      @background.blit screen, [0, 0]
    end

    def add_layer(layer)
      layer.setup_blitting_surface @background

      inserted = false
      for layer_group in (@layers) do
          if layer_group.layer_no == layer.layer_no then
            layer_group.add_layer layer
            inserted = true
            break
          end
      end

      if inserted == false
        new_group = Game::Core::LayerGroup.new layer.layer_no
        new_group.add_layer layer
        @layers << new_group
      end


    end
   end
end