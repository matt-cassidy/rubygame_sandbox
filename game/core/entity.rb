require "./game/core/game_object.rb"
require "./game/core/text_box.rb"
require "./game/core/collision_hitbox.rb"

module Game::Core

  class Entity < GameObject
    
    attr_reader :hitbox
    
    def initialize(px, py,is_player = false)
      super px, py
      @events = []
      @hitbox = CollisionHitbox.new
      @player =  is_player
      @location_text = TextBox.new px, py - 50
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

      @location_text.text = "xy=>#{'%.0f' % @px},#{'%.0f' % @py}"
      @location_text.update(@px,@py)
    end

    def screen_location
      return [@px,@py]
    end

    def is_player?
      return @player
    end
  end

end