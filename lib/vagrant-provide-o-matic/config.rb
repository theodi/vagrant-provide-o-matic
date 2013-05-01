module Vagrant
  module ProvideOMatic
    class Config < ::Vagrant.plugin('2', :config)
      attr_accessor :provide_o_matic_config_file

      def initialize
        super
        @provide_o_matic_config_file = UNSET_VALUE
      end

      def provide_o_matic_config_file=(value)
        @provide_o_matic_config_file = File.expand_path(value)
      end

      def validate(machine)
        errors = []
        errors << "Provide-o-Matic configuration not found at #{@provide_o_matic_config_file}." if !File.exists?(@provide_o_matic_config_file)

        { "provide-o-matic configuration" => errors }
      end

      def finalize!
        @provide_o_matic_config_file = File.expand_path "#{ENV['HOME']}/.chef/provide-o-matic.rb" if @provide_o_matic_config_file == UNSET_VALUE
      end
    end
  end
end