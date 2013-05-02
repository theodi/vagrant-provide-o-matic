module Vagrant
  module ProvideOMatic
    module Action
      class AfterDestroy
        include ::Vagrant::ProvideOMatic::EnvHelpers

        def initialize(app, env)
          @app = app
        end

        def call(env)
          remove_provider_file env
          @app.call(env)
        end

        def remove_provider_file env
          File.delete ".vagrant/machines/%s/provider" % [
              env[:machine].name
          ]
        end
      end
    end
  end
end