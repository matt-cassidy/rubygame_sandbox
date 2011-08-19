
module Game::Core

  class LayerGroup

    attr_reader :layers

    def initialize(layer_no,surface)
      @layers = Hash.new
      @layer_no = layer_no
      @visible = true
      @surface = surface
    end

    def add_layer (layer)
      #sets up how many tiles fit the width and height
      layer.setup_background @surface

      @layers[layer.entity_id] = layer
    end

    def remove_layer(entity_id)
       @layers.delete(entity_id)
    end

    def visible?
      return @visible
    end

    def layer_no?
      return @layer_no
    end

    def layers_amount
      return @layers.length
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
      @layers.each { |id,e| show_layer id  }
    end

    def show_layer(entity_id)
      @layers[entity_id].visible = true
    end

    def hide_all
      @visible = false
      @layers.each { |id,e| hide_layer id  }
    end

    def hide_layer(entity_id)
      @layers[entity_id].visible = false
    end

    def update clock,camera_pos
       @layers.each { |id,e|
         if e.visible == true
           e.update clock,camera_pos,@surface
         end
       }
    end
  end

end
