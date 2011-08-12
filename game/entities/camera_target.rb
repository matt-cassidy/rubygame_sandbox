require "./game/core/player_input.rb"
require "./game/core/entity.rb"
require "./game/entities/text_box.rb"

module Game::Entities

  class CameraTarget < Game::Core::Entity
    
    MOVE_SPEED = 2
    
    def initialize(view, pos)
      super view, pos, [10,10]
      @input = Game::Core::PlayerInput
      @hitbox.make_visible
      @image = Rubygame::Surface.new [10,10]
      @image.fill :white
      @debugtxt = Game::Core::Font.new "pirulen", 10
    end
  
    def updating
      handle_movement
      @debugtxt.text = "x=#{pos[0]},y=#{pos[1]}"
    end

    def drawing
      blit @image
      blit @debugtxt
    end

    def handle_movement
      x, y = 0,0
      x -= MOVE_SPEED if @input.key_pressed?( :left )
      x += MOVE_SPEED if @input.key_pressed?( :right )
      y -= MOVE_SPEED if @input.key_pressed?( :up ) # up is down in screen coordinates
      y += MOVE_SPEED if @input.key_pressed?( :down )
      if(x != 0 || y != 0)
        shift [x, y]
      end
    end

  end

end