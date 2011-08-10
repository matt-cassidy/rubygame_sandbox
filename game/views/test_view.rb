require "game/core/view"
require "game/core/collision_node"
require "game/core/collision_tree"
require "game/core/text_box.rb"
require "game/core/world_map.rb"
require "game/core/log.rb"
require "game/core/camera.rb"

module Game::Views

  class TestView < Game::Core::View

    def initialize
      super
      puts "init - Test View"
      @entities = Hash.new
      @cameras = Hash.new
      parent_collision_node = Game::Core::CollisionNode.new Rubygame::Rect.new(0, 0, 640, 480), 5
      @collision_tree = Game::Core::CollisionTree.new parent_collision_node

      @framerate_text = Game::Core::TextBox.new 10, 10
      @world = Game::Core::WorldMap.new

      @main_camera = Game::Core::Camera::new @world.full_size,320,240
      @main_camera.add_observer(self)

      #create_entity "Fox", 320, 240
      create_entity "Planet", 200, 200
    end

    def update(seconds, clock)
      @framerate_text.text = "frame rate: #{clock.framerate.to_int}"
      @collision_tree.update
      @entities.each do |id,e|
        e.cool_down_events seconds
        e.update_events seconds
      end
      @main_camera.follow_actor

    end

    def draw(screen)
      screen.fill(:black)

      #retrieve the center point where the camera would be over on the map
      point = @main_camera.get_position

      @world.draw screen, point[0],point[1]
      #@world.draw screen, 320,240
      @entities.each { |id,e| e.draw screen }
      @framerate_text.draw screen
      @main_camera.draw screen
      screen.update
    end

    def create_entity(name, px, py)
      Game::Core::Log.debug "Adding '#{name}' at #{px},#{py}"
      actor = Game::Core::ScriptManager.actors["#{name.downcase}"]
      require "./game/entities/#{name.downcase}.rb"
      entity = Game::Entities.const_get(name).new px, py, actor
      @entities[entity.goid] = entity
      @collision_tree.objects << entity

      #temp
      if name == "Fox" then
        @main_camera.set_actor(entity)
      end
    end


  end

end