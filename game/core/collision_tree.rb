require "game/core/collision_node"

module Game::Core

  class CollisionTree #AKA QuadTree
    
    attr_reader :collidable_objects
    attr_reader :objects
    attr_reader :parent_node
    
    def initialize(parent_node)
      @collidable_objects = []
      @objects = []
      @parent_node = parent_node
    end
    
    def self.make(size, depth)
      top = CollisionNode.new Rubygame::Rect.new(0, 0, size[0], size[1]), depth
      tree = CollisionTree.new top
      return tree
    end
    
    def update
      @collidable_objects.clear
      @objects.each do |obj|
        obj.hitbox.clear_colliding_objects
        if obj.hitbox.collidable? then 
          @collidable_objects << obj 
        end
      end
      @parent_node.update @collidable_objects
    end
    
  end

end