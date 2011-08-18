
module Game::Core

  class LayerGroup

    attr_reader :collection

    def initialize(layer_no,surface)
      @collection = Hash.new
      @layer_no = layer_no
      @visible = true
      @surface = surface
    end

    def add_layer (layer)
      #sets up how many tiles fit the width and height
      layer.setup_blit @surface

      @collection[layer.entity_id] = layer
    end

    def remove_layer(entity_id)
       @collection.delete(entity_id)
    end

    def visible?
      return @visible
    end

    def layer_no?
      return @layer_no
    end

    def flip
      @visible = !@visible
      if @visible then
        show_all
      else
        hide_all
      end
    end

    def show_all
      @visible = true
      @collection.each { |id,e| show_layer id  }
    end

    def show_layer(entity_id)
      @collection[entity_id].visible = true
    end

    def hide_all
      @visible = false
      @collection.each { |id,e| hide_layer id  }
    end

    def hide_layer(entity_id)
      @collection[entity_id].visible = false
    end

    def update clock,camera_pos
       @collection.each { |id,e|
         if e.visible == true
           e.update clock,camera_pos,@surface
         end
       }
    end
  end

end
