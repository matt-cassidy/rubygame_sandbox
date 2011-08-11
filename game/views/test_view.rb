require "game/core/view"
require "game/core/collision_node"
require "game/core/collision_tree"
require "game/core/text_box.rb"
require "game/core/world_map.rb"
require "game/core/log.rb"
require "game/entities/fox.rb"
require "game/entities/planet.rb"

module Game::Views

  class TestView < Game::Core::View

    def initialize
      super
    end
    
    def loading
      parent_collision_node = Game::Core::CollisionNode.new Rubygame::Rect.new(0, 0, 640, 480), 5
      @collision_tree = Game::Core::CollisionTree.new parent_collision_node

      @framerate_text = Game::Core::TextBox.new [10, 10], "framerate", 14, [255,255,255]
      
      @world = Game::Core::WorldMap.new
      
      @input = Game::Core::PlayerInput    
      
      player = Game::Entities::Fox.new [320,240]
      add_entity player
      @camera.follow player
      @collision_tree.objects << player
      
      planet1 = Game::Entities::Planet.new [100,100]
      add_entity planet1

      @collision_tree.objects << planet1

      planet2 = Game::Entities::Planet.new [2000,200]
      add_entity planet2


      planet3 = Game::Entities::Planet.new [100,100], false
      add_entity planet3
      @collision_tree.objects << planet3

      marker = Game::Core::TextBox.new [100, 100], "100,100", 14, [255,255,255]
      add_entity marker
      
    end
    
    def update(clock)
      
      handle_quit
      
      @framerate_text.text = "frame rate: #{clock.framerate.to_int}"
      
      @collision_tree.update
      
      #update camera position by updating the entity it's following
      @camera.target.update clock 
      
      @entities.each do |id,e|
        next if e == @camera.target #dont update camera target twice
        e.cool_down_events clock.seconds
        e.update clock
        e.move #move the entity to the destined position
      end
      
    end

    def draw(surface)
      
      #retrieve the center point where the camera would be over on the map

      @world.draw surface, @camera.pos
      
      @entities.each { |id,e| e.draw surface }
      
      @framerate_text.draw surface
      
    end

    def handle_quit
      if @input.quit_requested? then
        quit
      end
    end

  end

end