module Vagrant
  module ProvideOMatic
    module Action
      autoload :Derp, 'vagrant-provide-o-matic/action/derp'

      def self.derp
        ::Vagrant::Action::Builder.new.tap do |b|
          b.use setup
          b.use Vagrant::ProvideOMatic::Action::Derp
        end
      end

      def self.setup
        @setup ||= ::Vagrant::Action::Builder.new.tap do |b|
          b.use ::Vagrant::Action::Builtin::EnvSet, provide_o_matic: Vagrant::ProvideOMatic::Env.new
        end
      end
    end
  end
end