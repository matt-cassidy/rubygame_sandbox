
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
      @rect.collide_rect? hitbox.rect
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
    
  end
  
end