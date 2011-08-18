module Game::Core

  class Level

    def initialize(level_no = 1,object_hash)
       @level = Rubygame::Surface.load "./resource/img/level_#{level_no}.png"


    end

    def convert_to
      for y in @level.height
        #for x in @level.
      end
    end

  end


end