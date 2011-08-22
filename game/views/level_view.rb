require "game/entities/text_box.rb"
require "game/core/world_map.rb"
require "game/core/level_manager.rb"

module Game::Views

  class LevelView < Game::Core::View
    def initialize(parent)
      super parent
    end


    def loading
      @currently_follow = nil

      Game::Core::EntityManager.setup


      @framerate_text = Game::Entities::TextBox.new self, [10, 450], 14
      add_entity @framerate_text

      #convert_area_to_surface = level_manager.area_to_surface "test.area","test.level"
      layers = @level_manager.create_level "level_1.level"
      layers.each{|layer|
        @world.add_layer layer
      }
    end

    def updating
      @framerate_text.text = "Parallax frame rate: #{clock.framerate.to_int}"
      @world.update clock, @camera.pos.to_a
    end

    def drawing
      world.draw surface
    end

  end
end