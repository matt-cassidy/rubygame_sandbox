module Game::Core

  module Hex_Convert
    def hex_to_rgb (hex)
      if hex.nil?
        return [0,0,0]
      end
      red = hex[0..1]
      green=  hex[2..3]
      blue  = hex[4..5]
      return [red.to_i(16),green.to_i(16),blue.to_i(16)]
     end

     def rgb_to_hex(colour)
       #converts the color to the familiar HTML Hex format #FFFFFF
       #ignoring alpha channel for now
       return "%02x%02x%02x".upcase! % [colour[0],colour[1],colour[2]]
     end
  end

end