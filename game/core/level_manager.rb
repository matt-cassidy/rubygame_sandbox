require "game/core/layer.rb"
require "game/core/parallax_layer.rb"
require "game/core/hex_rgb.rb"

include Game::Core::Hex_Convert

module Game::Core

  class LevelManager


      def initialize(view)
        @view = view
      end

      def create_level (level_no)
        puts "create #{level_no}"
        level_config = eval File.open("./resource/level/#{level_no}").read

        level_layers = []

        level_config.each { | layer |
           level = Rubygame::Surface.load layer["image"]

           level_objects = surface_to_objects level,layer

           level_objects["entities"].each{ |e|
            @view.add_entity e
           }
           if layer["name"] != "sprites" then
             new_layer = Game::Core::Layer.new(level_objects["area"], layer["tiles"]["image"],layer["tiles"]["width"],layer["tiles"]["height"],layer["properties"])
             new_layer.config = layer
             level_layers << new_layer
           end
        }

        return level_layers


      end


     def surface_to_objects(surface,level_config)
        area = Array.new
        entities = Array.new

        for y in (0..(surface.height - 1))
          row = Array.new

          for x in (0..(surface.width - 1))

            hex = rgb_to_hex(surface.get_at [x,y])

            if level_config["colour_def"][hex].nil? == false then
              hex_def = level_config["colour_def"][hex]

              if hex_def.kind_of?(String) #is it an entity
                map_x = x * level_config["tiles"]["width"]
                map_y = y * level_config["tiles"]["height"]

                if hex_def == "PLAYER_START"
                  entities << player = create_entities(level_config["player"],[map_x,  map_y])
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

     def create_entities (entity_name,pos)
          entity = Game::Entities.const_get(entity_name)
          return entity.new @view,pos
      end


    end

end