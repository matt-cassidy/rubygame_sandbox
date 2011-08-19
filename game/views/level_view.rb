require "game/core/view"
require "game/entities/text_box.rb"
require "game/entities/camera_target.rb"
require "game/entities/mario.rb"
require "game/core/world_map.rb"
require "game/core/level_manager.rb"

module Game::Views

  class LevelView < Game::Core::View
    def initialize(parent)
      super parent
    end


    def loading
      @currently_follow = nil

      @world = Game::Core::WorldMap.new
      Game::Core::EntityManager.setup

      player = Game::Entities::CameraTarget.new self, [300,300]
      add_entity player
      camera.follow player


      @framerate_text = Game::Entities::TextBox.new self, [10, 450], 14
      add_entity @framerate_text

      #convert_area_to_surface = level_manager.area_to_surface "test.area","test.level"
      @world.add_layer  level_manager.create_layer "level_1.level"

     end
    def updating
      handle_switch_entities

      @framerate_text.text = "Parallax frame rate: #{clock.framerate.to_int}"
      @world.update clock, @camera.pos
    end

    def drawing
      @world.draw surface
    end

    def handle_switch_entities
       if @input.up?(:ctrl) && @input.up(:z) then

       end

       if @input.up?(:ctrl) && @input.up(:z) then

       end
    end
  end
end