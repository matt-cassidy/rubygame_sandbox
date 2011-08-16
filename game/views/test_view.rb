require "game/core/view"
require "game/core/collision_node"
require "game/core/collision_tree"
require "game/entities/text_box.rb"
require "game/core/layer.rb"
require "game/core/world_map.rb"
require "game/core/log.rb"
require "game/entities/fox.rb"
require "game/entities/planet.rb"

module Game::Views

  class TestView < Game::Core::View

    def initialize(parent)
      super parent
    end
    
    def loading
      
      @framerate_text = Game::Entities::TextBox.new self, [10, 10], 14
      add_entity @framerate_text

      layer = Game::Core::Layer.new "test","tiles",64,64,1, 0
      @world = Game::Core::WorldMap.new
      @world.add_layer layer
      
      @input = Game::Core::PlayerInput    
      
      player = Game::Entities::Fox.new self, [320,240]
      add_entity player
      
      planet1 = Game::Entities::Planet.new self, [100,100]
      add_entity planet1
      
      planet2 = Game::Entities::Planet.new self, [2000,200]
      add_entity planet2
      
      planet3 = Game::Entities::Planet.new self, [100,100], false
      add_entity planet3
      
      marker = Game::Entities::TextBox.new self, [300, 300], 14
      add_entity marker
      
      @camera.follow player
      
    end
    
    def updating
      @framerate_text.text = "frame rate: #{clock.framerate.to_int}"
      @world.update clock, @camera.pos
    end

    def drawing
      
      #retrieve the center point where the camera would be over on the map


      @world.draw surface
      
    end
    
  end

end