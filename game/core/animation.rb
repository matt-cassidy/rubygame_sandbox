require "rubygame"
require "./game/core/animation_reel.rb"

module Game::Core

  class Animation
    
    attr_reader :sprite_sheet
    attr_reader :reels
    attr_reader :current_reel
    attr_reader :sprite
    attr_reader :sprite_rect
    attr_reader :frame_time_counter
    
    def self.make(actor)
      animation = Animation.new actor[:sprite][:path], 
                                actor[:sprite][:size],
                                actor[:sprite][:animations]
      return animation
    end
    
    def initialize(sprite_path, sprite_size, animations)
      create_reels animations, sprite_size
      @frame_time_counter = 0
      @sprite_sheet = Rubygame::Surface.load(sprite_path)
      @sprite = Rubygame::Surface.new(sprite_size)
      @sprite_rect = Rubygame::Rect.new(@current_reel.position, sprite_size)
      @sprite_rect.center = @current_reel.position
    end
    
    def create_reels(animations, sprite_size)
      @reels = Hash.new
      animations.each do |name,anim|
        reel = AnimationReel.new name, sprite_size, anim[:frames], anim[:index], anim[:time]
        @reels[name] = reel
      end
      @current_reel = @reels[@reels.keys[0]]
    end
    
    def change(reel_name)
      return if reel_name == @current_reel.name
      @current_reel = @reels[reel_name]
      @current_reel.reset
      @sprite_rect.center = @current_reel.position
    end
    
    def animate
      @frame_time_counter += 1
      if @frame_time_counter >= @current_reel.current_frame_time
        @current_reel.move_next
        @sprite_rect.center = @current_reel.position
        @frame_time_counter = 0
      end
      @sprite_sheet.blit(@sprite, [0, 0], @sprite_rect)
    end
    
    def blit(screen, pos)
      #@sprite_sheet.blit(screen, [pos[0]-@sprite.w/2, pos[1]-@sprite.h/2], @sprite_rect)
      @sprite_sheet.blit(screen, pos, @sprite_rect)
    end
    
  end

end