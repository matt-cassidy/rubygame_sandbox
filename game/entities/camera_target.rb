require "./game/core/player_input.rb"
require "./game/core/entity.rb"
require "./game/entities/text_box.rb"

module Game::Entities

  class CameraTarget < Game::Core::Entity
    
    MOVE_SPEED = 1
    
    def initialize(pos)
      super pos, [10,10]
    end
    
    def load
      @input = Game::Core::PlayerInput
      @hitbox.make_visible
      @image = Rubygame::Surface.new [10,10]
      @image.fill :white
      @debugtxt = TextBox.new pos, "x,y", 8, :white
      @debugtxt.view = @view
    end
  
    def update
      handle_movement
      @debugtxt.text = "x=#{pos[0]},y=#{pos[1]}"
      @debugtxt.move screen_pos
    end

    def draw
      @image.blit @view.surface, screen_pos
      @debugtxt.draw
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