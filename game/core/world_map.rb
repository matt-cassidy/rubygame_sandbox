require "rubygame"
require "game/core/layer_group.rb"

module Game::Core

  class WorldMap
    
    attr_reader :area
    
    def initialize(size = [640,480])
      @entity_id = GOID.next
      #where is the world camera at
      @last_camera_pos = [-1,-1]

      @size = size

      @background = Rubygame::Surface.new [@size[0], @size[1]]

      @layers = [Game::Core::LayerGroup.new(0,@background)]

      @input = Game::Core::PlayerInput
    end

    def camera_moved?(camera_pos)
      if @last_camera_pos[0] != camera_pos[0] or @last_camera_pos[1] != camera_pos[1] then
        return true
      end
      return false
    end

    def update(clock,camera_pos)
      #convert camera position to use top left instead of centre position
      camera_top_left = [camera_pos[0] - (@size[0] / 2),camera_pos[1] - (@size[1] / 2)]

      changed = handle_layers

      #dont re-blit if the camera hasnt moved... blit_tiles is expensive
      if camera_moved?(camera_top_left) or changed == true then
          @background.fill([0,0,0])
          @layers.each { |group|
            if group.visible?
                group.update clock,camera_top_left
            end
          }

          @last_camera_pos = [camera_top_left[0],camera_top_left[1]]
      end

    end

    def handle_layers
      changed = false
      keys = [:number_1, :number_2,:number_3,:number_4,:number_5,:number_6,:number_7,:number_8,:number_9,:number_0]

      @layers.each{ | group |
        if @input.up?(keys[group.layer_no?]) then
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

      inserted = false
      for layer_group in (@layers) do
          if layer_group.layer_no? == layer.layer_no then
            layer_group.add_layer layer
            inserted = true
            break
          end
      end

      #if the layer was group was not found create a new layer group based on that layer number
      if inserted == false
        new_group = Game::Core::LayerGroup.new layer.layer_no,@background
        new_group.add_layer layer
        @layers << new_group
      end

      @layers.sort! { |a,b| a.layer_no? <=> b.layer_no? }

    end


    def to_config_file
      puts "making world config file"
      filename = "./resource/level/level_#{Time.new.inspect.gsub(/[ \-:]/,"_")}_#{@entity_id}.level"
      master_config = Array.new
      @layers.each { |group|
          group.layers.each {|id,layer|
             config =  layer.to_config_file
             master_config << config
          }
      }
      File.open(filename,'w'){|file|
        file.puts "[ "
        file.puts master_config
        file.puts " ]"
      }
      puts "saved config file to #{filename}"
    end
   end
end