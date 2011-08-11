require "game/core/view"
require "game/core/collision_node"
require "game/core/collision_tree"
require "game/core/text_box.rb"
require "game/core/world_map.rb"
require "game/core/log.rb"

module Game::Views

  class TestView < Game::Core::View

    def initialize
      super
    end
    
    def loading
      @entities = Hash.new

      parent_collision_node = Game::Core::CollisionNode.new Rubygame::Rect.new(0, 0, 640, 480), 5
      @collision_tree = Game::Core::CollisionTree.new parent_collision_node

      @framerate_text = Game::Core::TextBox.new [10, 10], "framerate", 14, [255,255,255]
      @world = Game::Core::WorldMap.new

      @main_camera = Game::Core::Camera::new @world.full_size, 320,240

      create_entity "Fox", 320, 240
      create_entity "Planet", 200, 200
      create_entity "Planet", 1000, 200
      create_entity "Planet", 150, 320
    end
    
    def follow_entity(who,pos)

      @entities.each do |id,e|
        #move the entity as long as it was not the one who caused the change
        if (e != who)then
          e.shift pos
        end
      end

    end
    
    def update(clock)
      @framerate_text.text = "frame rate: #{clock.framerate.to_int}"
      @collision_tree.update
      @entities.each do |id,e|
        e.cool_down_events clock.seconds
        e.update clock
      end
    end

    def draw(surface)
      #retrieve the center point where the camera would be over on the map
      point = @main_camera.get_position

      @world.draw surface, point[0],point[1]
      #@world.draw screen, 320,240
      @entities.each { |id,e| e.draw surface }
      @framerate_text.draw surface
    end

    def create_entity(name, px, py)
      Game::Core::Log.debug "Adding '#{name}' at #{px},#{py}"
      require "./game/entities/#{name.downcase}.rb"
      entity = Game::Entities.const_get(name).new [px, py]
      @entities[entity.goid] = entity
      @collision_tree.objects << entity

      #temp main player
      if name == "Fox" then
         puts "Test View create entity Fox"
        @main_camera.set_actor(entity)
        entity.add_observer(self,:follow_entity)
      end

    end

  end

end