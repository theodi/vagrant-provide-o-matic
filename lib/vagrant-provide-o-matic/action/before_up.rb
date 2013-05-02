module Vagrant
  module ProvideOMatic
    module Action
      class BeforeUp
        include ::Vagrant::ProvideOMatic::EnvHelpers

        def initialize(app, env)
          @app          = app
          @machine_name = env[:machine].name
        end

        def call(env)
          unless env[:provider]
            env[:provider] = get_provider_from_file || "virtualbox"
          end

          get_provider_specific_config env

          puts env[:machine].provider_config.auth_url

          @app.call(env)
        end
      end
    end
  end
end