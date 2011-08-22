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


      #adding layers to map

      layer0 = Game::Core::ParallaxLayer.new "test","./resource/img/tiles.png",64,64
      #@world.add_layer layer0

      layer1 = Game::Core::ParallaxLayer.new nil,"./resource/img/parallax_1.png",800,200,{"repeat_y"=> false,"pos" => [0,0],"speed" => [10,0],"layer_no" => 0}

      layer2 = Game::Core::ParallaxLayer.new nil,"./resource/img/parallax_2.png",800,120,{"repeat_y" => false,"pos" => [0,120],"speed" => [50,0],"layer_no" => 1}

      layer3 = Game::Core::ParallaxLayer.new nil,"./resource/img/parallax_3.png",800,200,{"repeat_y" => false,"pos" => [0,120],"speed" => [90,0],"layer_no" => 2}

      layer4 = Game::Core::ParallaxLayer.new nil,"./resource/img/parallax_4.png",800,200,{"repeat_y" => false,"pos" => [0,90],"speed" => [100,0],"layer_no" =>3}

      layer5 = Game::Core::ParallaxLayer.new nil,"./resource/img/parallax_5.png",1600,400,{"repeat_y" => false,"pos" => [0,0],"speed" => [150,0],"layer_no" => 4}

      @world.add_layer layer1
      @world.add_layer layer4
      @world.add_layer layer3
      @world.add_layer layer5
      @world.add_layer layer2

    end

    def updating
       @framerate_text.text = "Parallax frame rate: #{clock.framerate.to_int}"
       @world.update clock, @camera.pos.to_a
    end

    def drawing
      @world.draw surface
    end
  end

end