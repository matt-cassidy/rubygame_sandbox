require "rubygame"
require "game/core/text_box.rb"
require "game/core/player_input.rb"
require "observer"

module Game::Core

  class Camera < GameObject
    include Observable

    BOUNDARY_BOX_WIDTH  =64
    BOUNDARY_BOX_HEIGHT = 64
    def initialize(world,start_cx,start_cy,view_width=640,view_height=480,actor=nil)
        @input = PlayerInput.new

        @view_width=view_width
        @view_height=view_height

        @viewport = Rubygame::Rect.new(0,0, view_width, view_height)
        @world = Rubygame::Rect.new(0,0, world[0], world[1])
        puts world

        @map_cx = start_cx
        @map_cy = start_cy

        @actor = actor
      end

      def get_off_set
        #Returns an array that is where the camera's xy is in relation to the entire world
        #this represents the camera offset for world xy as the camera 'doesn't move'
        #[x,y]
        return [@map_cx - @view_width/2,@map_cy - @view_height / 2 ]
      end

      def get_position
        #returns where the camera's center is located on the map'
        return [@map_cx,@map_cy]
      end

      def set_view(view_width,view_height)
        @view_width = view_width
        @view_height = view_height
      end

      #change the actor
      def set_actor(actor)
        @actor = actor
        follow_actor
      end

      #move position to the actor
      def follow_actor
        @input.fetch
        if @actor.nil? == false then
          update_position(@actor.hitbox.rect.centerx,@actor.hitbox.rect.centery)
        else
          update_position(0,0)
        end
      end

      #move the camera to a position
      #this would be used to follow say a path
      def update_position(cx,cy)

            x, y = 0,0
            x -= 1 if @input.key_pressed?( :a )
            x += 1 if @input.key_pressed?( :d )
            y -= 1 if @input.key_pressed?( :w ) # up is down in screen coordinates
            y += 1 if @input.key_pressed?( :s )
            if(x != 0 || y != 0)
                 move x,y
                 changed
                 notify_observers(x,y)
            end
      end

      def move(x,y)
          new_x = @map_cx + x
          new_y = @map_cy + y

          #puts "new_x #{new_x} left+w #{@world.left + @view_width/2} right+width #{@world.right + @view_width/2}"
          if (new_x >= (@world.left + @view_width /2) and new_x <= (@world.right + @view_width/2)) then
              @map_cx = new_x
          end

          #puts "new_y #{new_y} left+w #{@world.bottom - @view_height /2} right+width #{@world.top + @view_height}"
          if (new_y <= (@world.bottom - @view_height /2) and new_y >= (@world.top + @view_height/2))then
              @map_cy = new_y
          end
      end

      def draw(screen)
        offset = get_off_set
        placeholderC = TextBox.new @viewport.centerx, @viewport.centery
        placeholderC.text = "offset xy #{offset[0]},#{offset[1]}"
        placeholderC.draw screen

        placeholderTL = TextBox.new @viewport.x, @viewport.y
        placeholderTL.text = "TL"
        placeholderTL.draw screen

        placeholderTR = TextBox.new @viewport.x + @viewport.w, @viewport.y
        placeholderTR.text = "TR"
        placeholderTR.draw screen

        placeholderBL = TextBox.new @viewport.x, @viewport.y + @viewport.h
        placeholderBL.text = "BL"
        placeholderBL.draw screen

        placeholderBR = TextBox.new @viewport.x + @viewport.w, @viewport.y + @viewport.h
        placeholderBR.text = "BR"
        placeholderBR.draw screen
      end

  end


end