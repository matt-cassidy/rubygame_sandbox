require "./game/core/entity.rb"
require "./game/core/collision_hitbox.rb"
require "./game/core/script_manager.rb"
require "./game/core/animation.rb"

module Game::Core

  class Sprite < Game::Core::Entity
    
    attr_reader :hitbox
    attr_reader :animation
    
    def initialize(view, pos)
      super view, pos
      @animation = Animation.new
      @hitbox = CollisionHitbox.new
    end
    
    def load_script(script_name)
      script = ScriptManager.actors[script_name]
      @animation.load script
      @hitbox.load script
    end
    
    def update
      super
      @animation.animate
    end
    
    def adjust
      super
      @hitbox.update @spos.to_a
    end
    
    def draw
      super
      cblit @hitbox
      cblit @animation
    end

    def change_animation(name)
      @animation.change name
      @hitbox.change_size @animation.current_hitbox
    end
    
  end

end