require "./game/core/entity.rb"

include Game::Core

module Game::Entities

  class Planet < Entity
    
    def initialize(pos)
      @actor = load_script "planet"
      
      super pos, @actor[:hitbox]
      @image = Rubygame::Surface.load(@actor[:sprite][:path])
      @hitbox.make_visible
      @angle = 2*Math::PI * rand
    end
    
    def update(clock)
      handle_movement clock.seconds
    end
    
    def draw(screen)
      @hitbox.draw screen
      @image.blit(screen, @hitbox.rect)
    end
    
    def handle_movement(seconds)
      @angle = ( @angle + 2*Math::PI / 4 * seconds) % ( 2*Math::PI)
      direction = [Math.sin(@angle), Math.cos(@angle)]
      if(direction[0] != 0 || direction[1] != 0)
        shift direction
      end
    end
      
  end

end