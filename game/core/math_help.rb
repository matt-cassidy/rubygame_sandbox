module MathHelp
  
  def deg2rad(d)
    d * Math::PI / 180
  end
 
  def rad2deg(r)
    r * 180 / Math::PI
  end

  def invtan(x)
    Math.atan2(x, 1.0)
  end
  
end