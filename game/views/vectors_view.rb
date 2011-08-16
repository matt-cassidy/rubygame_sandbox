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
      @vecman.draw(surface)
    end
    
    def updating
      @vecman.update clock.seconds
    end
   
   end
    
end

class VectorMan
  
  attr_reader :image
  attr_reader :pos
  attr_reader :acc
  attr_reader :vel
  attr_reader :jumping  
  
  def initialize
    @debug = Game::Core::Font.new "pirulen", 10
    @image = Rubygame::Surface.new [20,20]
    @image.fill :green
    @rect = Rubygame::Rect.new [320,240, 20, 20]
    @input = Game::Core::PlayerInput
    @pos = Game::Core::Vector2.new 320, 240
    @acc = Game::Core::Vector2.new 0, 0
    @vel = Game::Core::Vector2.new 0, 0
    @mass = 0.110
    @gravity = 0.981
    @jump_duration = 0.0
    @falling_duration = 0.0
    @height = 1.0
  end
  
  def falling? 
    @rect.bottom <= y_of_the_ground
  end
  
  def jumping?
    @input.down? :space
  end
  
  def moving_right?
    @input.key_pressed? :right
  end
  
  def moving_left?
    @input.key_pressed? :left
  end
  
  def y_of_the_ground
    460
  end
  
  def update(seconds)
    
    if falling?
      vel.y = 2
      @falling_duration += seconds
    else
      vel.y = 0
      @falling_duration = 0
    end
    
    if jumping? then
      vel.y = -100
      @jump_duration += seconds
    else
      @jump_duration = 0.0
    end
    
    if moving_right?
      vel.x = 1
    elsif moving_left?
      vel.x = -1
    elsif not falling?
      vel.x = 0
    end
    
    move
    update_debug_messages
  end
  
  def move
    @pos = pos + vel + acc
    @rect.centerx = @pos.x
    @rect.centery = @pos.y
  end
  
  def update_debug_messages
    fall = "%0.2f" % @falling_duration
    jump = "%0.2f" % @jump_duration
    direction = "%0.2f" %  vel.direction
    @debug.text = "fall [#{fall}]       jump [#{jump}]    direction [#{direction}]"
  end
  
  def draw(surface)
    @image.blit surface, pos.to_a
    @debug.blit surface, [10,10]
  end
  
end






