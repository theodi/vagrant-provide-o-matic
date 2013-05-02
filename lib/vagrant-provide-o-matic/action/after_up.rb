module Vagrant
  module ProvideOMatic
    module Action
      class AfterUp
        include ::Vagrant::ProvideOMatic::EnvHelpers

        def initialize(app, env)
          @app = app
        end

        def call(env)
          write_provider_to_file env
          @app.call(env)
        end

        def write_provider_to_file env
          File.write ".vagrant/machines/%s/provider" % [
              env[:machine].name
          ],
                     env[:provider]
        end
      end
    end
  end
end