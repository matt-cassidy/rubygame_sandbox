require "game/core/layer.rb"
require "game/core/parallax_layer.rb"
module Game::Core

  class LevelManager

      def initialize()
        puts "init - LevelLoader"
      end

      def create_layer (level_no,background)
        puts "create #{level_no}"
        level_hash = eval File.open("./resource/level/#{level_no}").read

        level = Rubygame::Surface.load level_hash["level_image"]

        area = Array.new
        #colours_in_level = Hash.new
        for y in (0..(level.height - 1))
          row = Array.new
          for x in (0..(level.width - 1))
            hex = rgb_to_hex(level.get_at [x,y])
            row << level_hash["colour_def"][hex]
          end
          area << row
        end

        return Game::Core::Layer.new area, level_hash["tiles"]["image"],level_hash["tiles"]["width"],level_hash["tiles"]["height"]
      end

      def hex_to_rgb (hex)
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

      def surface_to_area(surface,object_hash)


      end

      def area_to_surface(area,object_hash)
        level = area
        hash = object_hash

        if !area.kind_of?(Array)
            level =  eval File.open("./resource/area/#{area}").read
        end

        if !hash.kind_of?(File)
          hash =  eval File.open("./resource/level/#{object_hash}").read
        end

        width =  0
        height = level.length

        #ensures it gets the largest value
        for y in (0..(level.length - 1))
          if level[y].length > width
            width = level[y].length
          end
        end
        surface = Rubygame::Surface.new [width,height]

        #retrieve the max width of the area
        for y in (0..(surface.height - 1))
          for x in (0..(surface.width - 1))
              tile = level[y][x]

              hash["colour_def"].each { |key,value|
                if tile.kind_of?(Array)
                  if tile[0] == value[0] && tile[1] == value[1]
                    colour = hex_to_rgb(key)
                    surface.set_at [x,y],colour
                    break
                  end
                else
                  if tile == value
                    colour = hex_to_rgb(key)
                    surface.set_at [x,y],colour
                    break
                  end
                end
              }

          end
        end

        return surface

      end

    end

end