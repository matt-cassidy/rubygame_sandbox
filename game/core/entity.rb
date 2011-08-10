require "./game/core/game_object.rb"
require "./game/core/script_manager.rb"

module Game::Core

  class Entity < GameObject
    
    attr_reader :events
    attr_reader :actor
    
    def initialize(pos, script_name)
      load_script script_name
      super pos, @actor[:hitbox]
      @events = []
    end
    
    def cool_down_events(seconds)
      @events.each { |e| e.cool_down seconds } 
      @events.delete_if {|e| e.is_finished}
    end
    
    def load_script(script_name)
      @actor = ScriptManager.actors[script]
      if @actor.nil?
        Log.error "Script '#{script}' not found!"
      end
    end
  
  end

end