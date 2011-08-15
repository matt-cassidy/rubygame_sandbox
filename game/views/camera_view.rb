require "game/core/view"
require "game/core/text_box.rb"
require "game/entities/camera_target.rb"
require "game/entities/planet.rb"

module Game::Views

  class CameraView < Game::Core::View

    def initialize
      super
    end
    
    def loading
      @input = Game::Core::PlayerInput    
      
      player = Game::Entities::CameraTarget.new [300,300]
      add_entity player
      
      planet = Game::Entities::Planet.new [100,100], false
      add_entity planet
      
      planet2 = Game::Entities::Planet.new [200,200], true
      add_entity planet2

      #marker = Game::Core::TextBox.new [100, 100], "100,100", 14, [255,255,255]
      #add_entity marker
      
      @camera.follow planet2
      
    end
    
    def update(clock)
      
      handle_quit
      
      #updating the camera will automatically update the entity it's following
      @camera.update clock
      
      @entities.each do |id,e|
        next if e == @camera.target #dont update camera target twice
        e.cool_down_events clock.seconds
        e.update clock
      end
      
    end

    def draw(surface)
      
      @entities.each { |id,e| e.draw surface }
      
    end

    def handle_quit
      if @input.quit_requested? then
        quit
      end
    end

  end

end