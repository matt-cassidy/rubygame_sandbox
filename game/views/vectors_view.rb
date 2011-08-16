require "game/core/vector2"

module Game::Views

  class VectorsView < Game::Core::View
    
    def initialize(parent)
      super parent
    end
    
    def loading
      @vecman = VectorMan.new
    end
    
    def drawing
      @vecman.image.blit surface, @vecman.pos.to_a
    end
    
    def updating
      @vecman.update clock.seconds 
    end
   
   end
    
end

class VectorMan
  
  attr_reader :image
  attr_reader :pos
  attr_reader :accel
  attr_reader :vel
  attr_reader :jumping  
  
  def initialize
    @image = Rubygame::Surface.new [20,20]
    @image.fill :green
    @rect = Rubygame::Rect.new [320,240, 20, 20]
    @input = Game::Core::PlayerInput
    @pos = Game::Core::Vector2.new 320, 240
    @acc = Game::Core::Vector2.new 0, 1
    @vel = Game::Core::Vector2.new 0, 0
    @jumping = false
    @moving = false
  end
  
  def on_floor? 
    @rect.bottom <= 470
  end
  
  def jump_key_pressed?
    @input.key_pressed? :space
  end
  
  def update(seconds)
    
    if jump_key_pressed? then
      vel.y = -10;
      jumping = true;
    end

    if jumping then
      vel.y = vel.y + 1
      pos.y = pos.y + vel.y
    end

    if on_floor? then
      vel.y = 0;
      jumping = false;
    end
    
  end
  
end






