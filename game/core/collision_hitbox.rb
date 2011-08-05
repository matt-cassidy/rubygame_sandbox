
module Game::Core
  
  class CollisionHitbox
  
    attr_reader :colliding_with
    attr_reader :collidable
    attr_reader :rect 
    
    def initialize()
      @rect = nil
      @colliding_with = []
      @collidable = true
    end
    
    def create_rect(x,y,w,h)
      @rect = Rubygame::Rect.new [x, y], [w, h]
      center x, y
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
      if visible? then
        if colliding then
          @image.fill([178,34,34])
        else
          @image.fill([100, 100, 100])
        end
      end
      return colliding
    end
    
    def enable_collision
      @collidable = true
    end
    
    def disable_collision
      @collidable = false
    end
    
    def center(x, y)
      @rect.center = [x, y]
    end
    
    def draw(screen)
      return if not visible?
      @image.blit screen, @rect
    end
    
    def visible?
      @image.nil? == false
    end
    
  end
  
end