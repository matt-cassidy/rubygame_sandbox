require "game/core/view"
require "game/entities/text_box.rb"
require "game/entities/camera_target.rb"
require "game/core/layer.rb"
require "game/core/world_map.rb"
module Game::Views

  class ParallaxView < Game::Core::View

    def initialize(parent)
      super parent
    end

    def loading
      enable_transparency

      @framerate_text = Game::Entities::TextBox.new self, [10, 10], 14
      add_entity @framerate_text

      player = Game::Entities::CameraTarget.new self, [0,0]
      add_entity player

      camera.follow player

      @world = Game::Core::WorldMap.new 640,400
      #adding layers to map
      layer1 = Game::Core::Layer.new nil,"parallax_1",800,200,10, 0
      @world.add_layer layer1

      layer2 = Game::Core::Layer.new nil,"parallax_2",800,120,20, 1
      @world.add_layer layer2

      layer3 = Game::Core::Layer.new nil,"parallax_3",800,200,30, 2
      @world.add_layer layer3

      layer4 = Game::Core::Layer.new nil,"parallax_4",800,200,40, 3
      @world.add_layer layer4

      layer5 = Game::Core::Layer.new nil,"parallax_5",1600,400,50, 4
      @world.add_layer layer5

    end

    def updating
       @framerate_text.text = "Parallax frame rate: #{clock.framerate.to_int}"
       @world.update clock, @camera.pos
    end

    def drawing
      #retrieve the center point where the camera would be over on the map
      @world.draw surface
    end
  end

end