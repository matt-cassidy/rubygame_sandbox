
module Game::Core

  class LayerGroup

    attr_reader :collection
    attr_reader :layer_no
    attr_reader :visible

    def initialize(layer_no)
      @collection = Hash.new
      @layer_no = layer_no
      @visible = true
    end

    def add_layer (layer)
       @collection[layer.entity_id] = layer
    end

    def remove_layer(entity_id)
       @collection.delete(entity_id)
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

    def hide_all
      @visible = false
      @collection.each { |id,e| hide_layer id  }
    end

    def show_layer(entity_id)
      @collection[entity_id].visible = true
    end

    def hide_layer(entity_id)
      @collection[entity_id].visible = false
    end


  end

end
