require "./game/core/game_object.rb"
require "./game/core/collision_hitbox.rb"

module Game::Core

  class Entity < GameObject
    
    attr_reader :entity_id
    attr_reader :hitbox
    
    def initialize(px, py)
      super px, py
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
    
    def move(x,y)
      @px = @px + x
      @py = @py + y
      @hitbox.center @px, @py
    end
  end

end