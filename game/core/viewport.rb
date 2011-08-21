require "./game/core/entity.rb"

module Game::Core

  class Viewport < Entity
    
    attr_reader :target
    
    def initialize(view, pos, size)
      super view, pos
      @hitbox.disable_collision
    end
    
    def updating
      if following_target? then
        @target.update
        @pos.y = @target.pos.y
        @pos.x = @target.pos.x
        @view.camera.update
      end
    end
  
    def follow(entity)
      @target = entity
    end
    
    def following_target?
      return !@target.nil?  
    end
    
   end
    
end