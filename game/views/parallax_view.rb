require "game/core/view"
require "game/entities/text_box.rb"
require "game/entities/camera_target.rb"
require "game/core/parallax_layer.rb"
require "game/core/world_map.rb"
module Game::Views

  class ParallaxView < Game::Core::View

    def initialize(parent)
      super parent
    end

    def loading

      @framerate_text = Game::Entities::TextBox.new self, [10, 10], 14
      add_entity @framerate_text

      player = Game::Entities::CameraTarget.new self, [0,0]
      add_entity player

      camera.follow player

      @world = Game::Core::WorldMap.new
      #adding layers to map

      layer1 = Game::Core::Layer.new "test_2","tiles",64,64
      layer1.speed = [10,150]
      layer1.visible = false
      layer1.pos = [0,0]
      @world.add_layer layer1

      layer2 = Game::Core::ParallaxLayer.new nil,"parallax_2",800,120
      layer2.layer_no = 1
      layer2.speed = [50,100]
      layer2.pos = [0,0]
      @world.add_layer layer2

      layer3 = Game::Core::ParallaxLayer.new nil,"parallax_3",800,200
      layer3.layer_no = 2
      layer3.speed = [90,90]
      layer3.pos = [0,50]
      @world.add_layer layer3

      layer4 = Game::Core::ParallaxLayer.new nil,"parallax_4",800,200
      layer4.layer_no = 3
      layer4.speed = [100,50]
      layer4.pos = [0,90]
      @world.add_layer layer4

      layer5 = Game::Core::ParallaxLayer.new nil,"parallax_5",1600,400
      layer5.layer_no = 4
      layer5.speed = [150,40]
      layer5.pos = [0,0]
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