module Game::Core
  
  module Mathh #MathHelper
    
    def deg2rad(d)
      d * Math::PI / 180
    end
   
    def rad2deg(r)
      r * 180 / Math::PI
    end
    
    def acos(x)
      rad2deg( Math.acos x )
    end
    
    def atan2(x,y)
      rad2deg( Math.atan2(x,y) )
    end
    
  end

end