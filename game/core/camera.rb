require "rubygame"
require "game/core/text_box.rb"
require "game/core/player_input.rb"
require "observer"

module Game::Core

  class Camera
    include Observable

    BOUNDARY_BOX_WIDTH  =64
    BOUNDARY_BOX_HEIGHT = 64
    def initialize(world,start_cx,start_cy,view_width=640,view_height=480,entity=nil)
        @input = PlayerInput.new

        @view_width=view_width
        @view_height=view_height

        @viewport = Rubygame::Rect.new(0,0, view_width, view_height)
        @world = Rubygame::Rect.new(0,0, world[0], world[1])
        puts world

        @map_cx = start_cx
        @map_cy = start_cy

        @entity = entity
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

      #change the entity, listen to changes from this entity
      def set_actor(entity)
        @entity = entity
        @entity.add_observer(self)
      end

      #since the actor will indicate move away, camera must follow
      def update(who,pos)
        #puts "Camera updates callback who #{who}"
        move([-pos[0],-pos[1]])
        #puts "Camera updates callback end"
      end

      def move(pos)
          new_x = @map_cx + pos[0]
          new_y = @map_cy + pos[1]

          #puts "new_x #{new_x} left+w #{@world.left + @view_width/2} right+width #{@world.right + @view_width/2}"
          if (new_x >= (@world.left + @view_width /2) and new_x <= (@world.right + @view_width/2)) then
              @map_cx = new_x
          end

          #puts "new_y #{new_y} left+w #{@world.bottom - @view_height /2} right+width #{@world.top + @view_height}"
          if (new_y <= (@world.bottom - @view_height /2) and new_y >= (@world.top + @view_height/2))then
              @map_cy = new_y
          end

          #alert observers that a changed occurred
          changed
          #use the inverse to tell all to move the "away" from the camera
          notify_observers(self,[-pos[0],-pos[1]])
      end
  end


end