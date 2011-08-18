require "game/core/sprite_sheet.rb"
require "json"

module Game::Core

  class SpriteSheetManager
    
    class << self
      
       @@sheets = Hash.new
      
      def sheets
        @@sheets
      end
      
      def setup
        Log.info "Loading sprites..."
        Dir[File.join("./resource/sprites/*.json")].each do |file_name|
          Log.info "   #{file_name}"
          hash = open_json_doc file_name
          add_sprite_sheet hash
        end
      end
      
      def add_sprite_sheet(hash)
        sheet = SpriteSheet.new hash
        @@sheets[sheet.name] = sheet
      end
      
      def load(sheet_name, frame_key, src_rect)
        sheets[sheet_name].load frame_key, src_rect
      end
      
      private 
      
      def open_json_doc(file_name)
        lines = ""
        File.open(file_name).each_line{ |l| lines << l}
        return JSON.parse(lines)
      end
         
    end
    
  end
  
end