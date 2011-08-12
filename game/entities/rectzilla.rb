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
    
    def update
      #@screenpos.text = "x=#{spos[0]},y=#{spos[1]}"
      #@virtpos.text = "x=#{pos[0]},y=#{pos[1]}"
    end
    
    def draw
      blit @image
      blit @hitbox
      #blit @screenpos, spos, [-5,0]
      #blit @virtpos, spos, [5,0] 
    end
      
  end

end