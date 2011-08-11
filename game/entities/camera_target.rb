require "./game/core/player_input.rb"
require "./game/core/entity.rb"

module Game::Entities

  class CameraTarget < Game::Core::Entity
    
    MOVE_SPEED = 1
    
    def initialize(pos)
      super pos, [10,10]
      @input = Game::Core::PlayerInput
      @hitbox.make_visible
      @image = Rubygame::Surface.new [10,10]
      @image.fill :white
      @debugtxt = Game::Core::TextBox.new pos, "x,y", 8, :white
    end
  
    def update(clock)
      @debugtxt.view = @view
      handle_movement
      @debugtxt.text = "x=#{pos[0]},y=#{pos[1]}"
      @debugtxt.move screen_pos
    end

    def draw(screen)
      @image.blit screen, screen_pos
      @debugtxt.draw screen
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