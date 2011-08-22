require "game/core/view"
require "game/entities/text_box.rb"
require "game/entities/camera_target.rb"
require "game/entities/rotator.rb"

module Game::Views

  class CameraView < Game::Core::View

    def initialize(parent)
      super parent
    end
    
    def loading
      @framerate_text = Game::Entities::TextBox.new self, [10, 10], 14
      add_entity @framerate_text
      
      player = Game::Entities::CameraTarget.new self, [300,300]
      add_entity player
      
      r1 = Game::Entities::Rotator.new self, [100,100]
      add_entity r1
      
      r2 = Game::Entities::Rotator.new self, [200,200]
      add_entity r2
      
      marker = Game::Entities::TextBox.new self, [350,350], 10, false
      marker.text = "350,350"
      add_entity marker
      
      camera.follow player
      
    end
    
    def updating
      @framerate_text.text = "frame rate: #{clock.framerate.to_int}"
      
      
    end

    
  end

end