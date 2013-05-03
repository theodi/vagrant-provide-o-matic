module Vagrant
  module ProvideOMatic
    module Action
      class BeforeDestroy
        include ::Vagrant::ProvideOMatic::EnvHelpers

        def initialize(app, env)
          @app = app
        end

        def call(env)
          unless env[:provider]
            env[:provider] = get_provider_from_file || "virtualbox"
          end

          get_provider_specific_config env

          @app.call(env)
        end
      end
    end
  end
end