require "rubygame"
require "game/core/text_box.rb"

module Game::Core

  class Camera < GameObject
    BOUNDARY_BOX_WIDTH  =64
    BOUNDARY_BOX_HEIGHT = 64
    def initialize(world,start_cx,start_cy)
         #puts "Init Camera actor #{actor} w #{w} h#{h}"
         @viewport = Rubygame::Rect.new(0,0, 640, 480)
         @world = Rubygame::Rect.new(0,0, world["width"], world["height"])
         @map_cx = start_cx
         @map_cy = start_cy
      end

      def get_position
        return Hash["cx",@map_cx,"cy",@map_cy]
      end
      #change the actor
      def set_actor(actor)
        #puts "Update actor #{actor}"
        @actor = actor
        follow_actor
      end

      #move position to the actor
      def follow_actor
        #puts "following actor"
        if @actor.nil? == false then
          update_position
        end
      end

      #move the camera to a position
      #this would be used to follow say a path
      def update_position

        if @actor.hitbox.rect.centerx > @viewport.centerx+BOUNDARY_BOX_WIDTH then
          #puts "difference -x #{@actor.hitbox.rect.centerx-BOUNDARY_BOX_WIDTH - @viewport.centerx }"
          @map_cx = @actor.hitbox.rect.centerx-BOUNDARY_BOX_WIDTH
        end

        if @actor.hitbox.rect.centerx < @viewport.centerx-BOUNDARY_BOX_WIDTH then
          #puts "difference -x #{@actor.hitbox.rect.centerx+BOUNDARY_BOX_WIDTH - @viewport.centerx }"
          @map_cx = @actor.hitbox.rect.centerx+BOUNDARY_BOX_WIDTH
        end

        if @actor.hitbox.rect.centery > @viewport.centery+BOUNDARY_BOX_HEIGHT then
          #puts "difference -y #{@actor.hitbox.rect.centery-BOUNDARY_BOX_HEIGHT - @viewport.centery }"
          @map_cy = @actor.hitbox.rect.centery-BOUNDARY_BOX_HEIGHT
        end

        if @actor.hitbox.rect.centery < @viewport.centery-BOUNDARY_BOX_HEIGHT  then
          #puts "difference +y #{@actor.hitbox.rect.centery+BOUNDARY_BOX_HEIGHT - @viewport.centery }"
          @map_cy = @actor.hitbox.rect.centery+BOUNDARY_BOX_HEIGHT
        end

        @viewport.clamp!(@world)
      end

      def draw(screen)

        placeholderC = TextBox.new @viewport.centerx, @viewport.centery

        #placeholderC.text = "Cam cx,cy => #{@map_cx},#{@map_cy} "
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