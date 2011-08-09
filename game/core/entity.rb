require "./game/core/game_object.rb"
require "./game/core/collision_hitbox.rb"

module Game::Core

  class Entity < GameObject
    
    attr_reader :hitbox
    
    def initialize(pos)
      super pos
      @events = []
      @hitbox = CollisionHitbox.new
    end
  
    def update(seconds)
      #implement in sub class 
    end

    def cool_down_events(seconds_passed)
      @events.each do |event|
        event.cool_down seconds_passed
      end
      @events.delete_if {|e| e.is_finished}
    end
    
    def move(pos)
      @pos[0] = @pos[0] + pos[0]
      @pos[1]  = @pos[1] + pos[1]
      
      @hitbox.center @pos[0], @pos[1]
    end
  end

end