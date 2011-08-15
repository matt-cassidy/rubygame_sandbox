require "./game/core/entity.rb"

include Game::Core

module Game::Entities

  class Rectzilla < Entity
    
    def initialize(view, pos, size, regions=nil)
      super view, pos, size
      @image = Rubygame::Surface.new [10,10]
      @image.fill :green
      @hitbox.make_visible
      @screenpos = Game::Core::Font.new "pirulen", 10
      @virtpos = Game::Core::Font.new "pirulen", 10
      @collisiondebug = Game::Core::Font.new "pirulen", 10
      
      if not regions.nil? then
        @hitbox.add_regions regions
      end
    end
    
    def updating
      @screenpos.text = "x=#{spos[0]},y=#{spos[1]}"
      @virtpos.text = "x=#{pos[0]},y=#{pos[1]}"
      handle_collisions
    end
    
    def drawing
      cblit @image 
      cblit @hitbox
      blit @screenpos, spos, [15,-8]
      blit @virtpos, spos, [15,8] 
      blit @collisiondebug, spos, [0,-40]
    end
    
    def handle_collisions
      text = " "
      if @hitbox.colliding? then
        collisions = @hitbox.colliding_regions
        collisions.each { |c| text += "#{c[0]}" }
      end
      @collisiondebug.text = text
    end
    
  end

end