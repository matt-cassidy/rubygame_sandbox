require "./game/core/entity.rb"

include Game::Core

module Game::Entities

  class Planet < Entity
    
    def initialize(px, py, actor,is_player = false)
      super px, py,is_player
      @image = Rubygame::Surface.load(actor[:sprite][:path])
      @hitbox.create_rect(px, py, @image.w, @image.h)
      @hitbox.make_visible
      @angle = 2*Math::PI * rand
    end
    
    def update_events(seconds)
      handle_movement seconds
    end
    
    def draw(screen)
      @hitbox.draw screen
      @image.blit(screen, @hitbox.rect)
      @location_text.draw screen
    end
    
    def handle_movement(seconds)
      @angle = ( @angle + 2*Math::PI / 4 * seconds) % ( 2*Math::PI)
      direction = [Math.sin(@angle), Math.cos(@angle)]
      if(direction[0] != 0 || direction[1] != 0)
        move direction[0], direction[1] 
      end
    end
      
  end

end