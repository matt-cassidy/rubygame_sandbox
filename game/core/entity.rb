require "./game/core/game_object.rb"
require "./game/core/script_manager.rb"

module Game::Core

  class Entity < GameObject
    
    def initialize(pos, size)
      super pos, size
    end
    
    def load_script(script_name)
      script = ScriptManager.actors[script_name]
      if script.nil? then 
        Log.error "Script '#{script_name}' does not exist"
      end
      return script
    end
  
  end

end