
module Game::Core

  class EntityFactory
    
    def create(name, px, py,is_player = false)
      Log.debug "Adding '#{name}' at #{px},#{py} and is player: #{is_player}"
      actor = ScriptManager.actors["#{name.downcase}"]
      require "./game/entities/#{name.downcase}.rb"
      return Game::Entites.const_get(name).new px, py, actor, is_player
    end
    
  end

end