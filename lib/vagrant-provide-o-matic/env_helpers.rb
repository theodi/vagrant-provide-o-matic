module Vagrant
  module ProvideOMatic
    module EnvHelpers
       def provide_o_matic_config_file(env)
        # Make sure that the default is set
        env[:machine].config.provide_o_matic.finalize!

        env[:provide_o_matic].ui.info "provide-o-matic.rb location set to '#{env[:machine].config.provide_o_matic.provide_o_matic_config_file}'"
        env[:machine].config.provide_o_matic.provide_o_matic_config_file
      end
    end
  end
end