require "rubygame"
require "./game/core/text_box.rb"

module Game::Core

  class Camera < GameObject
      def initialize(actor = nil,worldWidth,worldHeight)
         #puts "Init Camera actor #{actor} w #{w} h#{h}"
         @rect = Rubygame::Rect.new(0,0, 320, 240)
         @world = Rubygame::Rect.new(0,0, worldWidth, worldHeight)
         update_actor(actor)
      end

      def get_position
        return
      end
      #change the actor
      def update_actor(actor)
        #puts "Update actor #{actor}"
        @actor = actor
        follow_actor
      end

      #move position to the actor
      def follow_actor
        #puts "following actor"
        if @actor.nil? == false then
          update_position(@actor.px,@actor.py)
        end
      end

      #move the camera to a position
      #this would be used to follow say a path
      def update_position(cx,cy)
        #puts "update position xy=> #{cx},#{cy}"
        if @actor.hitbox.rect.centerx > @rect.centerx+64 then
            @rect.centerx = @actor.hitbox.rect.centerx-64
        end

        if @actor.hitbox.rect.centerx < @rect.centerx-64 then
            @rect.centerx = @actor.hitbox.rect.centerx+64
        end

        if @actor.hitbox.rect.centery > @rect.centery+64 then
            @rect.centery = @actor.hitbox.rect.centery-64
        end

        if @actor.hitbox.rect.centery < @rect.centery-64  then
            @rect.centery = @actor.hitbox.rect.centery+64
        end
        @rect.clamp!(@world)
      end

      def draw(screen)
        placeholderC = TextBox.new @rect.centerx, @rect.centery
        placeholderC.text = "X"
        placeholderC.draw screen

        placeholderTL = TextBox.new @rect.x, @rect.y
        placeholderTL.text = "TL"
        placeholderTL.draw screen

        placeholderTR = TextBox.new @rect.x + @rect.w, @rect.y
        placeholderTR.text = "TR"
        placeholderTR.draw screen

        placeholderBL = TextBox.new @rect.x, @rect.y + @rect.h
        placeholderBL.text = "BL"
        placeholderBL.draw screen

        placeholderBR = TextBox.new @rect.x + @rect.w, @rect.y + @rect.h
        placeholderBR.text = "BR"
        placeholderBR.draw screen
      end
  end


end