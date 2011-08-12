require "./game/core/entity.rb"

module Game::Core

  class Viewport < Entity
    
    attr_reader :target
    
    def initialize(pos,size)
      super pos, size
      @hitbox.disable_collision
    end
    
    def update
      if following_target? then
        @target.do_update
        move @target.pos
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