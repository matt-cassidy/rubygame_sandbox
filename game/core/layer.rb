
module Game::Core

  class Layer

    attr_writer :disabled
    attr_reader :tile_width
    attr_reader :tile_height

    def initialize (area,tile_width,tile_height)
       @area = eval File.open("./resource/area/#{area}.area").read
       @disabled = false
       @tile_width = tile_width
       @tile_height = tile_height
    end

  end

end