require "game/views/start_view.rb"

module Game::Core

  class ViewManager

    def initialize
      Log.info "Initializing view manager..."

      resolution = [640,480]
      Log.info "Creating screen #{resolution}"
      @screen = Rubygame::Screen.new resolution, 0, [Rubygame::HWSURFACE,Rubygame::DOUBLEBUF]
      @screen.title = "Sandbox"

      fps = 60
      Log.info "Clocking game at #{fps} fps"
      @clock = Rubygame::Clock.new
      @clock.target_framerate = fps
      @clock.enable_tick_events

      @seconds = 0
      
      PlayerInput.setup
      
      ScriptManager.load_scripts_from "./resource/actor"

      Rubygame::TTF.setup

      resource_dir = "./../Resource"
      Rubygame::Surface.autoload_dirs << File.join(resource_dir, "img")
      Rubygame::Sound.autoload_dirs   << File.join(resource_dir, "sfx")
      Rubygame::Music.autoload_dirs   << File.join(resource_dir, "music")
      
      @master_view = Game::Views::StartView.new
      @master_view.show
    end

    def update
      @screen.fill :black
      PlayerInput.fetch
      @seconds = @clock.tick.seconds
      process_view @master_view
      @screen.flip
    end
    
    def process_view(view)
      return if not view.visible?
      update_view view
      draw_view view
      view.children.each do |child| 
        process_view child
      end
    end
    
    def update_view(view)
      load_view view
      return if view.frozen?
      check_quit_request view
      view.update @seconds, @clock
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
      view.loading 
      view.loaded = true
    end
    
    def draw_view(view)
      view.draw @screen
    end
    
  end


end