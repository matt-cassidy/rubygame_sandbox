require "game/views/start_view.rb"

module Game::Core

  class ViewManager

    def initialize
      Log.info "Initializing view manager..."

      @views = []

      resolution = [640,480]
      Log.info "Creating screen #{resolution}"
      @screen = Rubygame::Screen.new resolution, 0, [Rubygame::HWSURFACE,Rubygame::DOUBLEBUF]
      @screen.title = "Sandbox"

      fps = 60
      Log.info "Clocking game at #{fps} fps"
      @clock = Rubygame::Clock.new
      @clock.target_framerate = fps
      @clock.enable_tick_events

      ScriptManager.load_scripts_from "./resource/actor"

      Rubygame::TTF.setup

      resource_dir = "./../Resource"
      Rubygame::Surface.autoload_dirs << File.join(resource_dir, "img")
      Rubygame::Sound.autoload_dirs   << File.join(resource_dir, "sfx")
      Rubygame::Music.autoload_dirs   << File.join(resource_dir, "music")

      add_view Game::Views::StartView.new
    end

    def update
      seconds = @clock.tick.seconds
      @views.each { |view| view.update seconds, @clock }
    end

    def draw
      @views.each { |view| view.draw @screen }
      @screen.flip
    end

    def add_view(view)
      puts "setting view manager #{view}"
      view.view_manager = self
      @views << view
    end

    def remove_view(view)
      @views.delete view
    end


  end


end