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
      enable_transparency

      @framerate_text = Game::Entities::TextBox.new self, [10, 10], 14
      add_entity @framerate_text

      player = Game::Entities::CameraTarget.new self, [0,0]
      add_entity player

      camera.follow player

      @world = Game::Core::WorldMap.new
      #adding layers to map

      #tile to use, width,height, start pos, speed [x,y], layer
      layer0 = Game::Core::ParallaxLayer.new "test_2", "tiles",64,64,[0,100]
      layer0.layer_num = 0
      layer0.speed = [1,10]


      @world.add_layer layer0

      #layer1 = Game::Core::ParallaxLayer.new nil,"parallax_1",800,200,[0,100]
      #layer1.layer_num = 0
      #layer1.speed = [10,10]
      #layer1.visible = false
      #@world.add_layer layer1

      layer2 = Game::Core::ParallaxLayer.new nil,"parallax_2",800,120,[0,100]
      layer2.layer_num = 1
      layer2.speed = [50,20]
      layer2.visible = false
      @world.add_layer layer2

      layer3 = Game::Core::ParallaxLayer.new nil,"parallax_3",800,200,[0,100]
      layer3.layer_num = 2
      layer3.speed = [90,30]
      layer3.visible = false
      @world.add_layer layer3

      layer4 = Game::Core::ParallaxLayer.new nil,"parallax_4",800,200,[0,100]
      layer4.layer_num = 3
      layer4.speed = [100,40]
      layer4.visible = false
      @world.add_layer layer4

      layer5 = Game::Core::ParallaxLayer.new nil,"parallax_5",1600,400,[0,0]
      layer5.layer_num = 4
      layer5.speed = [150,150]
      layer5.visible = false
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