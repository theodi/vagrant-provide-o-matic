module Vagrant
  module ProvideOMatic
    class Plugin < Vagrant.plugin('2')
      name "vagrant-butcher"
      description <<-DESC
      Allow multiple providers from the same Vagrantfile
      DESC

      action_hook(:vagrant_provide_o_matic_cleanup, :machine_action_create) do |hook|
        hook.after(::Vagrant::Action::Builtin::ConfigValidate, Vagrant::ProvideOMatic::Action.derp)
      end

      config("provide-o-matic") do
        Config
      end
    end
  end
end