require "./game/core/player_input.rb"
require "./game/core/entity.rb"

module Game::Entities

  class CameraTarget < Game::Core::Entity
    
    def initialize(view, pos)
      super view, pos
      @input = Game::Core::PlayerInput
      @image = Rubygame::Surface.new [10,10]
      @image.fill :white
      @debugtxt = Game::Core::Font.new "pirulen", 10
    end
  
    def updating
      handle_movement
      @debugtxt.text = "x=#{pos.x},y=#{pos.y}"
    end

    def drawing
      cblit @image
      blit @debugtxt, spos, [5,-5]
    end

    def handle_movement
      x, y = 0,0
      x -= MOVE_SPEED if @input.key_pressed?( :left )
      x += MOVE_SPEED if @input.key_pressed?( :right )
      y -= MOVE_SPEED if @input.key_pressed?( :up ) # up is down in screen coordinates
      y += MOVE_SPEED if @input.key_pressed?( :down )
      if(x != 0 || y != 0)
        @pos.x += x
        @pos.y += y
      end
    end

  end

end