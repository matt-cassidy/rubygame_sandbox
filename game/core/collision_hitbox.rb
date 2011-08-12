
module Game::Core
  
  class CollisionHitbox
  
    attr_reader :colliding_with
    attr_reader :collidable
    attr_reader :rect
    
    def initialize(pos, size)
      @rect = nil
      @colliding_with = []
      @collidable = true
      @rect = Rubygame::Rect.new(pos[0], pos[1], size[0], size[1])
      center [pos[0],pos[1]]
    end
    
    def make_visible
      @image = Rubygame::Surface.new([@rect.w, @rect.h])
      @image.set_alpha 100
      @image.fill([100, 100, 100])
    end
    
    def clear_colliding_objects
      @colliding_with.clear
    end
    
    def collide_with(object)
      if not @colliding_with.include? object
        @colliding_with << object
      end
    end
    
    def colliding?
      @colliding_with.size > 0
    end
    
    def collidable?
      return false if @rect.nil?
      @collidable
    end
    
    def collision_detected?(hitbox)
      colliding = @rect.collide_rect? hitbox.rect
      color_rect colliding
      return colliding
    end
    
    def color_rect(colliding)
      if visible? then
        if colliding then
          @image.fill([178,34,34])
        else
          @image.fill([100, 100, 100])
        end
      end
    end
    
    def enable_collision
      @collidable = true
    end
    
    def disable_collision
      @collidable = false
    end
    
    def center(pos)
      #@rect.center = pos
    end
    
    def blit(surface, pos)
      return if not visible?
      @image.blit surface, [@rect.x,@rect.y]
    end
    
    def visible?
      @image.nil? == false
    end
    
  end
  
end