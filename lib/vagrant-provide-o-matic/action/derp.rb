module Vagrant
  module ProvideOMatic
    module Action
      class Derp
        include ::Vagrant::ProvideOMatic::EnvHelpers

        def initialize(app, env)
          @app = app
        end

        def call(env)
          @app.call(env)
        end
      end
    end
  end
end