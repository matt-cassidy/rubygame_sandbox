require "game/core/view"
require "game/entities/text_box.rb"
require "game/entities/camera_target.rb"

module Game::Views

  class ParallaxView < Game::Core::View

    def initialize(parent)
      super parent
    end

    def loading
       @framerate_text = Game::Entities::TextBox.new self, [10, 10], 14
      add_entity @framerate_text

      marker = Game::Entities::TextBox.new self, [320,240], 10, false
      marker.text = "x"
      add_entity marker

      camera.follow marker
    end

    def updating
       @framerate_text.text = "Parallax frame rate: #{clock.framerate.to_int}"
    end
  end

end