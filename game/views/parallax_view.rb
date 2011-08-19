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

      layer0 = Game::Core::ParallaxLayer.new "test","tiles",64,64

      #@world.add_layer layer0

      layer1 = Game::Core::ParallaxLayer.new nil,"parallax_1",800,200,{"repeat_y"=> false,"pos" => [0,0],"speed" => [10,0],"layer_no" => 1}
      puts "name:#{layer1.name} layer_no:#{layer1.layer_no}"

      @world.add_layer layer1

      layer2 = Game::Core::ParallaxLayer.new nil,"parallax_2",800,120,{"repeat_y" => false,"pos" => [0,120],"speed" => [50,0],"layer_no" => 2}
      puts "name:#{layer2.name} layer_no:#{layer2.layer_no}"
      @world.add_layer layer2

      layer3 = Game::Core::ParallaxLayer.new nil,"parallax_3",800,200,{"repeat_y" => false,"pos" => [0,0],"speed" => [90,0],"layer_no" => 3}
      puts "name:#{layer3.name} layer_no:#{layer3.layer_no}"
      @world.add_layer layer3

      layer4 = Game::Core::ParallaxLayer.new nil,"parallax_4",800,200,{"repeat_y" => false,"pos" => [0,90],"speed" => [100,0],"layer_no" => 4}
      puts "name:#{layer4.name} layer_no:#{layer4.layer_no}"
      @world.add_layer layer4

      layer5 = Game::Core::ParallaxLayer.new nil,"parallax_5",1600,400,{"repeat_y" => false,"pos" => [0,0],"speed" => [150,0],"layer_no" => 5}
      puts "name:#{layer5.name} layer_no:#{layer5.layer_no}"
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