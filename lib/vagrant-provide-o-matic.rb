require 'vagrant'
require 'vagrant-provide-o-matic/version'
require 'vagrant-provide-o-matic/errors'

module Vagrant
  module ProvideOMatic
    autoload :Action,     'vagrant-provide-o-matic/action'
    autoload :Config,     'vagrant-provide-o-matic/config'
    autoload :Env,        'vagrant-provide-o-matic/env'
    autoload :EnvHelpers, 'vagrant-provide-o-matic/env_helpers'
  end
end

require 'vagrant-provide-o-matic/plugin'
