require "./game/core/mathh"

include Game::Core::Mathh

module Game::Core
  
  class Vector2
    
    class << self
      
      def max(v,u)
        return v if v >= u
        return u
      end
      
      def min(v,u)
        return v if v <= u
        return u
      end
      
      def angle(v,u)
        Mathh.acos Vector2.normalize(v).dot(Vector2.normalize(u))
      end
      
      def one
        Vector2.new 1,1
      end
      
      def zero
        Vector2.new 0,0
      end
      
      def add(v,u)
        Vector2.new (v.x + u.x), (v.y + u.y)
      end
      
      def subtract(v,u)
        Vector2.new (v.x - u.x), (v.y - u.y)
      end
      
      def multiply(v, num)
        Vector2.new v.x * num, v.y * num
      end
      
      def divide(v, num)
        product = Vector2.zero
        return product if num == 0 
        product.x = v.x / num if v.x != 0
        product.y = v.y / num if v.y != 0
        return product
      end
      
      def distance(v,u)
        a = u.y - v.x
        b = u.y - v.y
        return Math.sqrt( (a ** 2) + (b ** 2) )
      end
      
      def direction(v)
        return -1 if v.zero?
        d = Mathh.atan2(v.y, v.x)
        return d if d > 0
        return d = 360 + d
      end
      
      def dot(v,u)
        (v.x * u.x) + (v.y * u.y)
      end
      
      def interpolate(v, u, control)
        x = v.x * (1-control) + u.x * control
        y = v.y * (1-control) + u.y * control
        Vector2 x, y
      end
      
      def equal?(v,u)
        v.x == u.x and v.y == u.y
      end
      
      def unit(v)
        x = v.x / v.length
        y = v.y / v.length
        return Vector2.new x, y
      end
      
      def negate(v)
        Vector2.new -v.x, -v.y
      end
      
      def normalize(v)
        inverse = 1 / v.length
        x = v.x * inverse
        y = v.y * inverse
        Vector2.new x, y
      end
      
      def unit?(v)
        v.length == 1
      end
      
      def greater(v,u)
        v.length > u.length
      end
      
      def less(v,u)
        v.length < u.length
      end
      
      def greater_eql(v,u)
        v.length >= u.length
      end
      
      def less_eql(v,u)
        v.length <= u.length
      end
      
    end
    
    def initialize(x,y)
      @components = [x.to_f,y.to_f]
      @clamp = []
    end
    
    def x()
      @components[0]
    end
    
    def x=(value)
      unless clamped? 
        @components[0] = value.to_f
      else
        if value >= @clamp[0].x && value <= @clamp[1].x 
          @components[0] = value.to_f
        end
      end
    end
    
    def y()
      @components[1]
    end
    
    def y=(value)
      unless clamped?
        @components[1] = value.to_f
      else
        if value >= @clamp[0].y && value <= @clamp[1].y
          @components[1] = value.to_f
        end
      end
    end
    
    def clamp(min,max)
      release_clamp
      @clamp << min
      @clamp << max
    end
    
    def clamped?
      @clamp.size == 2 
    end
    
    def release_clamp
      @clamp.clear
    end
    
    def add(other)
      Vector2.add(self,other)
    end
    
    def +(other)
      Vector2.add(self,other)
    end
    
    def subtract(other)
      Vector2.subtract self, other
    end
    
    def -(other)
      Vector2.subtract self, other
    end
    
    def multiply(num)
      Vector2.multiply self, num
    end
    
    def *(num)
      Vector2.multiply self, num
    end
    
    def divide(num)
      Vector2.divide self, num
    end
    
    def /(num)
      Vector2.divide self, num 
    end
    
    def angle(other)
      Vector2.angle self, other
    end
    
    def distance(other)
      Vector2.distance self, other  
    end
    
    def direction
      Vector2.direction self
    end
    
    def dot(other)
      Vector2.dot self, other
    end
    
    def length
      Math.sqrt( (x ** 2) + (y ** 2) )
    end
    
    def negate
      Vector2.negate self
    end
    
    def >(other)
      Vector2.greater self, other
    end
    
    def >=(other)
      Vector2.greater_eql self, other
    end
    
    def <(other)
      Vector2.less self, other
    end
    
    def <=(other)
      Vector2.less_eql self, other
    end
    
    def ==(other)
      return false unless Vector2 === other
      Vector2.equal? self, other
    end
    
    def eql?(other)
      return false unless Vector2 === other
      Vector2.equal? self, other
    end
    
    def to_s
      "[#{x},#{y}]"
    end
    
    def to_a
      @components
    end
    
    def normalize!
      release_clamp
      v = Vector2.normalize self
      self.x = v.x
      self.y = v.y
    end
    
    def unit
      Vector2.unit self
    end
    
    def unit?
      Vector2.unit? self
    end
    
    def interpolate(other, control)
      Vector2.interpolate self, other, control
    end
    
    def zero?
      self == Vector2.zero
    end
    
    def -@()
      Vector2.negate self
    end
    
  end

end