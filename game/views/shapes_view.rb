module Game::Views

  class ShapesView < Game::Core::View
    
    def initialize(parent)
      super parent
    end
    
    def loading
      @colorkey = [240, 140, 240]
      
      @line = Rubygame::Surface.new [300,300], 0, [Rubygame::HWSURFACE,Rubygame::DOUBLEBUF]
      #@line.colorkey = @colorkey
      #@line.fill @colorkey
      @line.draw_line [0,0], [300,300], :blue
      @line.draw_line [300,0], [0,300], :red
      
      @poly = Rubygame::Surface.new [100,100], 0, [Rubygame::HWSURFACE,Rubygame::DOUBLEBUF] 
      @poly.colorkey = @colorkey
      @poly.fill @colorkey
      @poly.draw_polygon [[0,0],[50,0],[100,100],[0,0]], :white
      
      @debug = Game::Entities::TextBox.new self, [5,10], 10
      add_entity @debug
    end
    
    def update

    end
    
    def drawing
      
      @line.blit surface, [100,100]
      @poly.blit surface, [250,320]
    end
    
   end
    
end