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
      @level_manager = Game::Core::LevelManager.new
      @world = Game::Core::WorldMap.new

      player = Game::Entities::CameraTarget.new self, [320,240]
      add_entity player

      camera.follow player

      convert_area_to_surface = @level_manager.area_to_surface "test.area","test.level"
      @world.add_layer  @level_manager.create_layer "level_1.level",true


     end
    def updating
       @world.update clock, @camera.pos
    end

    def drawing
      @world.draw surface
    end
  end
end