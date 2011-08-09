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

      @entities = Hash.new

      parent_collision_node = Game::Core::CollisionNode.new Rubygame::Rect.new(0, 0, 640, 480), 5
      @collision_tree = Game::Core::CollisionTree.new parent_collision_node

      @framerate_text = Game::Core::TextBox.new 10, 10
      @world = Game::Core::WorldMap.new

      create_entity "Fox", 100, 100
      create_entity "Planet", 200, 200
    end

    def update(seconds, clock)
      @framerate_text.text = "frame rate: #{clock.framerate.to_int}"
      @collision_tree.update
      @entities.each do |id,e|
        e.cool_down_events seconds
        e.update seconds
      end
    end

    def draw(screen)
      screen.fill(:black)
      @world.draw screen, 320, 240
      @entities.each { |id,e| e.draw screen }
      @framerate_text.draw screen
    end

    def create_entity(name, px, py)
      Game::Core::Log.debug "Adding '#{name}' at #{px},#{py}"
      actor = Game::Core::ScriptManager.actors["#{name.downcase}"]
      require "./game/entities/#{name.downcase}.rb"
      entity = Game::Entities.const_get(name).new px, py, actor
      @entities[entity.goid] = entity
      @collision_tree.objects << entity
    end

  end

end