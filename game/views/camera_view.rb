require "game/core/view"
require "game/entities/text_box.rb"
require "game/entities/camera_target.rb"
require "game/entities/planet.rb"

module Game::Views

  class CameraView < Game::Core::View

    def initialize(parent)
      super parent
    end
    
    def load
      @input = Game::Core::PlayerInput    
      
      player = Game::Entities::CameraTarget.new self, [300,300]
      add_entity player
      
      planet = Game::Entities::Planet.new self, [100,100], false
      add_entity planet
      
      planet2 = Game::Entities::Planet.new self, [200,200], true
      add_entity planet2

      #marker = Game::Core::TextBox.new [100, 100], "100,100", 14, [255,255,255]
      #add_entity marker
      
      @camera.follow player
      
    end
    
    def update
      @entities.each { |id,e| e.update }
    end
    
    def draw
      @entities.each { |id,e| e.draw }
    end
    
  end

end