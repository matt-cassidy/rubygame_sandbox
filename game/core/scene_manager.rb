require "./game/core/script_manager.rb"
require "./game/core/text_box.rb"
require "./game/core/world_map.rb"

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
    end
    
    def draw
      @screen.fill(:black)
      @world.draw @screen, 320, 240
      @framerate_text.draw @screen
      @entities.each { |id,e| e.draw @screen }
      @screen.flip 
    end
    
    def add(name, px, py)
      entity = @entity_factory.create name, px, py
      @entities[entity.goid] = entity
      @collision_tree.objects << entity
    end
      
end

end