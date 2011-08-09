require "./game/core/script_manager.rb"
require "./game/core/text_box.rb"
require "./game/core/world_map.rb"
require "./game/core/camera.rb"
module Game::Core
  
  class SceneManager
    
    def initialize(screen, clock, entity_factory, collision_tree)
      @screen = screen
      @clock = clock
      @entities = Hash.new
      @entity_factory = entity_factory
      @collision_tree = collision_tree
      @seconds = 0
      @framerate_text = TextBox.new 10, 10
      @world = WorldMap.new
      @player = nil
      @main_camera = Camera.new @player, 640,480
    end
    
    def tick
      @seconds = @clock.tick.seconds
      @framerate_text.text = "frame rate: #{@clock.framerate.to_int}"
      update
      draw
    end
    
    def update
      @collision_tree.update
      @entities.each do |id,e| 
        e.cool_down_events @seconds
        e.update @seconds
      end
      @main_camera.follow_actor

    end
    
    def draw
      @screen.fill(:black)
      @world.draw @screen, @player.px, @player.py
      @entities.each { |id,e| e.draw @screen }
      @framerate_text.draw @screen
      @main_camera.draw @screen
      @screen.flip 
    end
    
    def add(name, px, py,is_player = false)
      entity = @entity_factory.create name, px, py,is_player
      @entities[entity.goid] = entity
      @collision_tree.objects << entity

      if entity.is_player? then
        @player = entity
        @main_camera.update_actor(@player)
      end

    end
      
end

end