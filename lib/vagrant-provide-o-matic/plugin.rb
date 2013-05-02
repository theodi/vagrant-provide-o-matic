module Vagrant
  module ProvideOMatic
    class Plugin < Vagrant.plugin('2')
      name "vagrant-provide-o-matic"
      description <<-DESC
      Allow multiple providers from the same Vagrantfile
      DESC

      action_hook(:vagrant_provide_o_matic_up, :machine_action_up) do |hook|
        hook.before(::Vagrant::Action::Builtin::ConfigValidate, Vagrant::ProvideOMatic::Action.before_up)
        hook.after(::Vagrant::Action::Builtin::ConfigValidate, Vagrant::ProvideOMatic::Action.after_up)
      end

      action_hook(:vagrant_provide_o_matic_destroy, :machine_action_destroy) do |hook|
        hook.after(::Vagrant::Action::Builtin::ConfigValidate, Vagrant::ProvideOMatic::Action.after_destroy)
      end

      action_hook(:vagrant_provide_o_matic_ssh, :machine_action_ssh) do |hook|
        hook.before(::Vagrant::Action::Builtin::ConfigValidate, Vagrant::ProvideOMatic::Action.before_ssh)
      end

#     action_hook(:vagrant_provide_o_matic_derp, :machine_action_halt) do |hook|
#     end
#
#     action_hook(:vagrant_provide_o_matic_derp, :machine_action_suspend) do |hook|
#     end
#
#     action_hook(:vagrant_provide_o_matic_derp, :machine_action_reload) do |hook|
#     end
#
#     action_hook(:vagrant_provide_o_matic_derp, :machine_action_resume) do |hook|
#     end
#
#     action_hook(:vagrant_provide_o_matic_derp, :machine_action_status) do |hook|
#     end

      config("provide_o_matic") do
        Config
      end
    end
  end
end