Vagrant.require_plugin "vagrant-provide-o-matic"

number_of_nodes = 1
hostname = "vague"

Vagrant.configure("2") do |config|
#  config.butcher.knife_config_file = '.chef/knife.rb'
  config.provide_o_matic.provide_o_matic_config_file = '.provide-o-matic/provide-o-matic.rb'

  number_of_nodes.times do |n|

    index = "%02d" % [
        n + 1
    ]

    config.vm.define :"#{hostname}_#{index}" do |config|
      config.vm.box      = "precise64"

#      config.vm.provision :chef_client do |chef|
#        chef.node_name              = "%s-%s" % [
#            hostname,
#            index
#        ]
#        chef.environment            = "vagrant"
#        chef.chef_server_url        = "https://chef.theodi.org"
#        chef.validation_client_name = "chef-validator"
#        chef.validation_key_path    = ".chef/chef-validator.pem"
#        chef.run_list               = chef.run_list = [
#            "recipe[git]"
#        ]
#      end

    end
  end
end
