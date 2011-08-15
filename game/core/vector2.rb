include MathHelp

class Vector2
  
  
  class << self
    
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
    
    def dot(v,u)
      (v.x * u.x) + (v.y * u.y)
    end
    
    def equal?(v,u)
      v.x == u.x and v.y == u.y
    end
    
    def unit(v)
      x = v.x / v.length
      y = v.y / v.length
      return [x, y]
    end
    
  end
  
  attr_reader :components
  attr_reader :unit
  
  def initialize(x,y)
    @components = [x.to_f,y.to_f]
    @unit = Vector2.unit self
  end
  
  def x()
    @components[0]
  end
  
  def x=(value)
    @components[0] = value.to_f
  end
  
  def y()
    @components[1]
  end
  
  def y=(value)
    @components[1] = value.to_f
  end
  
  def unitx
    @unit[0]
  end
  
  def unity
    @unit[1]
  end
  
  def add(other)
    Vector2.add(self,other)
  end
  
  def +(other)
    add other
  end
  
  def subtract(other)
    Vector2.subtract self, other
  end
  
  def -(other)
    subtract other
  end
  
  def multiply(num)
    Vector2.multiply self, num
  end
  
  def *(num)
    multiply num
  end
  
  def divide(num)
    Vector2.divide self, num
  end
  
  def /(num)
    divide num  
  end
  
  def distance(other)
    Vector2.distance self, other  
  end
  
  def direction
    rad = MathHelp.invtan(y / x)
    deg = MathHelp.rad2deg rad
    return 180 - deg
  end
  
  def dot(other)
    Vector2.dot self, other
  end
  
  def length
    return Math.sqrt( (x ** 2) + (y ** 2) )
  end
  
  def ==(other)
    return false unless Vector2 === other
    Vector2.equal? self, other
  end
  
  def eql?(other)
    self == other
  end
  
  def to_s
    "[#{x},#{y}]"
  end
  
  def to_a
    @components
  end
  
end