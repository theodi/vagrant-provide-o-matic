module Vagrant
  module ProvideOMatic
    class Plugin < Vagrant.plugin('2')
      name "vagrant-provide-o-matic"
      description <<-DESC
      Allow multiple providers from the same Vagrantfile
      DESC

      action_hook(:vagrant_provide_o_matic_derp, :machine_action_up) do |hook|
        puts "*** up ***"
        hook.after(::Vagrant::Action::Builtin::ConfigValidate, Vagrant::ProvideOMatic::Action.derp)
      end

      action_hook(:vagrant_provide_o_matic_derp, :machine_action_destroy) do |hook|
        puts "*** destroy ***"
      end

      action_hook(:vagrant_provide_o_matic_derp, :machine_action_halt) do |hook|
        puts "*** halt ***"
      end

      action_hook(:vagrant_provide_o_matic_derp, :machine_action_ssh) do |hook|
        puts "*** ssh ***"
      end

      action_hook(:vagrant_provide_o_matic_derp, :machine_action_suspend) do |hook|
        puts "*** suspend ***"
      end

      action_hook(:vagrant_provide_o_matic_derp, :machine_action_reload) do |hook|
        puts "*** reload ***"
        hook.after(::Vagrant::Action::Builtin::ConfigValidate, Vagrant::ProvideOMatic::Action.derp)
      end

      action_hook(:vagrant_provide_o_matic_derp, :machine_action_resume) do |hook|
        puts "*** resume ***"
      end

      action_hook(:vagrant_provide_o_matic_derp, :machine_action_status) do |hook|
        puts "*** status ***"
        hook.after(::Vagrant::Action::Builtin::ConfigValidate, Vagrant::ProvideOMatic::Action.derp)
      end

      config("provide_o_matic") do
        Config
      end
    end
  end
end