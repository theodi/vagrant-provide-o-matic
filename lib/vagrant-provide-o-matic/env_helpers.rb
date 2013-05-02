module Vagrant
  module ProvideOMatic
    module EnvHelpers
      def provide_o_matic_config_file(env)
        # Make sure that the default is set
        env[:machine].config.provide_o_matic.finalize!

        env[:provide_o_matic].ui.info "provide-o-matic.yml location set to '#{env[:machine].config.provide_o_matic.provide_o_matic_config_file}'"
        env[:machine].config.provide_o_matic.provide_o_matic_config_file
      end

      def get_provider_from_file
        f = File.read ".vagrant/machines/%s/provider" % [
            @machine_name
        ]

        f.empty? ? nil : f.strip

      rescue
        nil
      end

      def get_provider_specific_config env
        y = YAML.load File.open env[:machine].config.provide_o_matic.provide_o_matic_config_file
        conf = y[env[:provider]]
        if conf && conf.is_a?(Hash)
          conf.each_pair do |section, values|
            values.each_pair do |k, v|
              env[:machine].config.send(section).send("#{k}=", v)
            end
          end
        end
      end
    end
  end
end