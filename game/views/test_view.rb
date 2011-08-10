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

      #os, text, font_size, color
      @framerate_text = Game::Core::TextBox.new [10, 10], "framerate", 14, [255,255,255]
      @world = Game::Core::WorldMap.new

      @main_camera = Game::Core::Camera::new @world.full_size,320,240

      create_entity "Fox", [320, 240]
      create_entity "Planet", [200, 200]
      create_entity "Planet", [1000, 200]
      create_entity "Planet", [150, 320]
    end

    def update(who,pos)
      puts "test view update callback#{who}"
      @entities.each do |id,e|
        #move the entity as long as it was not the one who caused the change
        if (e != who)then
          e.move pos
        end
      end
      puts "test view update callback end"
    end

    def update_screen(seconds, clock)
      @framerate_text.text = "frame rate: #{clock.framerate.to_int}"
      @collision_tree.update
      @entities.each do |id,e|
        e.cool_down_events seconds
        e.update seconds
      end
    end

    def draw(screen)
      screen.fill(:black)

      #retrieve the center point where the camera would be over on the map
      point = @main_camera.get_position

      @world.draw screen, point[0],point[1]
      #@world.draw screen, 320,240
      @entities.each { |id,e| e.draw screen }
      @framerate_text.draw screen
      screen.update
    end

    def create_entity(name, pos)
      Game::Core::Log.debug "Adding '#{name}' at #{pos[0]},#{pos[1]}"
      actor = Game::Core::ScriptManager.actors["#{name.downcase}"]
      require "./game/entities/#{name.downcase}.rb"
      entity = Game::Entities.const_get(name).new pos, actor
      @entities[entity.goid] = entity
      @collision_tree.objects << entity

      #temp main player
      if name == "Fox" then
        @main_camera.set_actor(entity)
        entity.add_observer(self)
      end
    end


  end

end