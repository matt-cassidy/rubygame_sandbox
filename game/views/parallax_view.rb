require "game/core/view"
require "game/entities/text_box.rb"
require "game/entities/camera_target.rb"
require "game/entities/mario.rb"
require "game/core/parallax_layer.rb"
require "game/core/world_map.rb"
module Game::Views

  class ParallaxView < Game::Core::View

    def initialize(parent)
      super parent
    end

    def loading

      @framerate_text = Game::Entities::TextBox.new self, [10, 450], 14
      add_entity @framerate_text

      @mario = Game::Entities::Mario.new self, [320,240]
      add_entity @mario

      camera.follow_y = false
      camera.follow @mario

      @world = Game::Core::WorldMap.new
      #adding layers to map

      layer0 = Game::Core::ParallaxLayer.new "test","tiles",64,64
      #layer0.make_parallax nil,1,[10,10],[0,0]

      #@world.add_layer layer0

      layer1 = Game::Core::ParallaxLayer.new nil,"parallax_1",800,200
      layer1.make_parallax nil,1,[10,0],[0,0]

      @world.add_layer layer1

      layer2 = Game::Core::ParallaxLayer.new nil,"parallax_2",800,120
      layer2.layer_no = 1
      layer2.make_parallax nil,1,[50,0],[0,120]

      @world.add_layer layer2

      layer3 = Game::Core::ParallaxLayer.new nil,"parallax_3",800,200
      layer3.layer_no = 2
      layer3.make_parallax nil,1,[90,0],[0,50]
      @world.add_layer layer3

      layer4 = Game::Core::ParallaxLayer.new nil,"parallax_4",800,200
      layer4.layer_no = 3
      layer4.make_parallax nil,1,[100,0],[0,100]
      @world.add_layer layer4

      layer5 = Game::Core::ParallaxLayer.new nil,"parallax_5",1600,400
      layer5.layer_no = 4
      layer5.make_parallax nil,1,[150,0],[0,00]
      @world.add_layer layer5

    end

    def updating
       @framerate_text.text = "Parallax frame rate: #{clock.framerate.to_int}"
       @world.update clock, @camera.pos
    end

    def drawing
      @world.draw surface
    end
  end

end