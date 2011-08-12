require "game/views/start_view.rb"
require "game/core/game_clock"

module Game::Core

  class ViewManager
    
    attr_reader :clock
    attr_reader :screen
    
    def initialize
      Log.info "Initializing view manager..."

      resolution = [640,480]
      Log.info "Creating screen #{resolution}"
      @screen = Rubygame::Screen.new resolution, 0, [Rubygame::HWSURFACE,Rubygame::DOUBLEBUF]
      @screen.title = "Sandbox"

      fps = 60
      Log.info "Clocking game at #{fps} fps"
      rgclock = Rubygame::Clock.new
      rgclock.target_framerate = fps
      rgclock.enable_tick_events

      @clock = GameClock.new rgclock 
      
      PlayerInput.setup
      
      ScriptManager.load_scripts_from "./resource/actor"

      Rubygame::TTF.setup

      resource_dir = "./../Resource"
      Rubygame::Surface.autoload_dirs << File.join(resource_dir, "img")
      Rubygame::Sound.autoload_dirs   << File.join(resource_dir, "sfx")
      Rubygame::Music.autoload_dirs   << File.join(resource_dir, "music")
      
      @master_view = Game::Views::StartView.new
      @master_view.view_manager = self
      @master_view.show
    end

    def tick
      @clock.tick
      PlayerInput.fetch
      @screen.fill :black
      refresh @master_view
      @screen.flip
    end
    
    def refresh(view)            
      check_quit_request view
      update view
      draw view
      view.children.each do |child| 
        refresh child
      end  
    end
    
    def update(view)
      return if not view.visible?
      if not view.frozen? then
        load_view view
        view.update
      end
    end
    
    def draw(view)
      return if not view.visible?
      view.draw
    end
    
    def check_quit_request(view)
      if view.quit_requested? then
        Log.info "Quit requested by #{view.class}"
        @master_view.close
      end
    end
    
    def load_view(view)
      return if view.loaded?
      Log.info "Loading view #{view.class}"
      view.load
      view.finished_loading 
    end
    
  end


end