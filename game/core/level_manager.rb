require "game/core/layer.rb"
require "game/core/parallax_layer.rb"


module Game::Core

  class LevelManager


      def initialize(view)
        @view = view
      end

      def create_level (level_no)
        puts "create #{level_no}"
        level_hash = eval File.open("./resource/level/#{level_no}").read

        layers = []
        level_hash.each { |id,layer |
           level = Rubygame::Surface.load layer["image"]

           level_objects = surface_to_objects level,layer

           level_objects["entities"].each{ |e|
            @view.add_entity e
           }
           if layer["name"] != "sprites" then
            layers << Game::Core::Layer.new(level_objects["area"], layer["tiles"]["image"],layer["tiles"]["width"],layer["tiles"]["height"],layer["properties"])
           end
        }

        return layers


      end


     def surface_to_objects(surface,level_hash)
        area = Array.new
        entities = Array.new

        for y in (0..(surface.height - 1))
          row = Array.new

          for x in (0..(surface.width - 1))

            hex = rgb_to_hex(surface.get_at [x,y])

            if level_hash["colour_def"][hex].nil? == false then
              hex_def = level_hash["colour_def"][hex]

              if hex_def.kind_of?(String) #is it an entity
                map_x = x * level_hash["tiles"]["width"]
                map_y = y * level_hash["tiles"]["height"]

                if hex_def == "PLAYER_START"
                  entities << player = create_entities(level_hash["player"],[map_x,  map_y])
                  @view.camera.follow player
                else
                  entities << create_entities(hex_def,[map_x,  map_y])
                end
                row << nil  #TODO:somehow create a tile behind it
              else #background
                row << hex_def
              end

            else
              row << 0
            end

          end
          area << row

        end
        return Hash["area" => area, "entities" => entities]
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

      def create_entities (entity_name,pos)
          entity = Game::Entities.const_get(entity_name)
          return entity.new @view,pos
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




    end

end