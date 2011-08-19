module Game::Core

  class EntityManager

      class << self

        @@entities = Hash.new

        def entities
          @@entities
        end

        def setup
          Log.info "EntityManager - Loading Entities"
          Dir[File.join("./game/entities/*.rb")].each do |file_name|
            require file_name
          end
        end


        def get(name)
           return Game::Entities.const_get(name)
        end
      end

  end

end