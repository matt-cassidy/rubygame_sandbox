
module Game::Core

  class GOID
    
    @@gobject_id_counter = 0
    
    def self.next
      @@gobject_id_counter += 1
    end
    
  end

end