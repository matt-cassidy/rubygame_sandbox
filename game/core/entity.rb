require "./game/core/game_object.rb"
require "./game/core/text_box.rb"
require "./game/core/collision_hitbox.rb"
require "observer"

module Game::Core

  class Entity < GameObject
    include Observable
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
      #player objects should override this method

      @pos[0] = @pos[0] + pos[0]
      @pos[1]  = @pos[1] + pos[1]
      
      @hitbox.center @pos[0], @pos[1]
      changed
      notify_observers(self,pos)
    end

  end

end