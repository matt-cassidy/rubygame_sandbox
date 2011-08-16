module Game::Views

  class InputView < Game::Core::View
    
    def initialize(parent)
      super parent
    end
    
    def loading
      @input = Game::Core::PlayerInput
      @keysup = Game::Core::Font.new "pirulen", 12
      @keysdown = Game::Core::Font.new "pirulen", 12
      @keyspress = Game::Core::Font.new "pirulen", 12
    end
    
    def drawing
      @keysup.blit surface, [10,10]
      @keysdown.blit surface, [10,50]
      @keyspress.blit surface, [10,100]
    end
    
    def updating
      if @input.keysdown.size > 0 then
        @keysdown.text = "keys-down: #{@input.keysdown.to_s}"
      end
      
      if @input.keysup.size > 0 then
        @keysup.text = "keys-up: #{@input.keysup.to_s}"
      end
      
      @keyspress.text = "keys-press: #{@input.keyspress.to_s}"
    end
   
   end
    
end