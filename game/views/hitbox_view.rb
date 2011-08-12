require "game/entities/camera_target.rb"
require "game/entities/rectzilla.rb"
require "game/core/view"

module Game::Views

  class HitboxView < Game::Core::View

    def initialize(parent)
      super parent
    end
    
    def loading
      
      rect1 = Game::Entities::Rectzilla.new self, [200,200], [50,50]
      add_entity rect1
      
      rect2 = Game::Entities::Rectzilla.new self, [400,400], [10,10]
      add_entity rect2

      rect2 = Game::Entities::Rectzilla.new self, [720,520], [20,20]
      add_entity rect2

      target = Game::Entities::CameraTarget.new self, [300,300]
      add_entity target 

      camera.follow target
          
    end
    
  end

end