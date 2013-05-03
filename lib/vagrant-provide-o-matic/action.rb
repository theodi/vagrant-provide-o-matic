module Vagrant
  module ProvideOMatic
    module Action
      autoload :BeforeUp, 'vagrant-provide-o-matic/action/before_up'
      autoload :AfterUp, 'vagrant-provide-o-matic/action/after_up'
      autoload :BeforeSsh, 'vagrant-provide-o-matic/action/before_ssh'
      autoload :BeforeStatus, 'vagrant-provide-o-matic/action/before_status'
      autoload :AfterDestroy, 'vagrant-provide-o-matic/action/after_destroy'
      autoload :BeforeDestroy, 'vagrant-provide-o-matic/action/before_destroy'

#      def self.derp
#        ::Vagrant::Action::Builder.new.tap do |b|
#          b.use setup
#          b.use Vagrant::ProvideOMatic::Action::Derp
#        end
#      end

      def self.before_up
        ::Vagrant::Action::Builder.new.tap do |b|
          b.use setup
          b.use Vagrant::ProvideOMatic::Action::BeforeUp
        end
      end

      def self.after_up
        ::Vagrant::Action::Builder.new.tap do |b|
          b.use setup
          b.use Vagrant::ProvideOMatic::Action::AfterUp
        end
      end

      def self.before_ssh
        ::Vagrant::Action::Builder.new.tap do |b|
          b.use setup
          b.use Vagrant::ProvideOMatic::Action::BeforeSsh
        end
      end

      def self.before_status
        ::Vagrant::Action::Builder.new.tap do |b|
          b.use setup
          b.use Vagrant::ProvideOMatic::Action::BeforeStatus
        end
      end

      def self.after_destroy
        ::Vagrant::Action::Builder.new.tap do |b|
          b.use setup
          b.use Vagrant::ProvideOMatic::Action::AfterDestroy
        end
      end

      def self.before_destroy
        ::Vagrant::Action::Builder.new.tap do |b|
          b.use setup
          b.use Vagrant::ProvideOMatic::Action::BeforeDestroy
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