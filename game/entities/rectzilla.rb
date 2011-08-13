require "./game/core/entity.rb"

include Game::Core

module Game::Entities

  class Rectzilla < Entity
    
    def initialize(view, pos, size)
      super view, pos, size
      @image = Rubygame::Surface.new [10,10]
      @image.fill :green
      @hitbox.make_visible
      @screenpos = Game::Core::Font.new "pirulen", 10
      @virtpos = Game::Core::Font.new "pirulen", 10
    end
    
    def updating
      @screenpos.text = "x=#{spos[0]},y=#{spos[1]}"
      @virtpos.text = "x=#{pos[0]},y=#{pos[1]}"
    end
    
    def drawing
      cblit @image 
      cblit @hitbox
      blit @screenpos, spos, [15,-8]
      blit @virtpos, spos, [15,8] 
    end
      
  end

end