require 'ostruct'
require 'yaml'

number_of_nodes   = 2
hostname          = "vague"
rackspace_flavour = "512MB"
ubuntu_version    = "Precise"

y = YAML.load File.open ".chef/rackspace_secrets.yaml"

rackspace                 = OpenStruct.new
rackspace.username        = y["username"]
rackspace.api_key         = y["api_key"]
rackspace.flavor          = /#{rackspace_flavour}/
rackspace.image           = /#{ubuntu_version}/
rackspace.public_key_path = "./.chef/id_rsa.pub"
rackspace.endpoint        = "https://lon.servers.api.rackspacecloud.com/v2"
rackspace.auth_url        = "lon.identity.api.rackspacecloud.com"

default_provider = "virtualbox"

full_hostname = hostname

def load_provider_files
  h = {}

  Dir.glob(".vagrant/machines/*/provider").each do |b|
    bits       = b.split "/"
    h[bits[2]] = File.read(b).strip
  end

  h
end

def save_provider_files h
  h.each_pair do |name, provider|
#    puts "Recording provider for %s" % [
#        name
#    ]
    File.open "%s/%s/%s/%s" % [
        ".vagrant",
        "machines",
        name,
        "provider"
    ],        "w" do |f|
      f.write provider
    end
  end
end

passed_provider = nil
ARGV.each_index do |i|
  if ARGV[i] == "--provider"
     passed_provider = ARGV[i + 1]
  end
end

if passed_provider
  default_provider = passed_provider
  node_providers = {}
else
  node_providers = load_provider_files
end

Vagrant.configure("2") do |config|
  config.butcher.knife_config_file = '.chef/knife.rb'

  number_of_nodes.times do |n|

    index = "%02d" % [
        n + 1
    ]

    config.vm.define :"#{hostname}_#{index}" do |config|
      node_providers["#{hostname}_#{index}"] ||= default_provider
      provider                               = node_providers["#{hostname}_#{index}"]

      case provider
        when "rackspace"
          box = "dummy"
        else
          box           = "precise64"
          full_hostname = "%s-%s" % [
              hostname,
              ENV["USER"]
          ]
      end

      config.vm.box      = box
      config.vm.hostname = "%s-%s" % [
          hostname,
          index
      ]

      config.vm.provider :rackspace do |rs|
        rs.username        = rackspace.username
        rs.api_key         = rackspace.api_key
        rs.flavor          = rackspace.flavor
        rs.image           = rackspace.image
        rs.public_key_path = rackspace.public_key_path
        rs.endpoint        = rackspace.endpoint
        rs.auth_url        = rackspace.auth_url
      end


      if provider == "rackspace"
        config.ssh.private_key_path = "./.chef/id_rsa"
        config.ssh.username         = "root"
        config.vm.provision :shell, :inline => "curl -L https://www.opscode.com/chef/install.sh | bash"
      end

      config.vm.provision :chef_client do |chef|
        chef.node_name              = "%s-%s" % [
            full_hostname,
            index
        ]
        chef.environment            = "vagrant"
        chef.chef_server_url        = "https://chef.theodi.org"
        chef.validation_client_name = "chef-validator"
        chef.validation_key_path    = ".chef/chef-validator.pem"
        chef.run_list               = chef.run_list = [
            "recipe[git]"
        ]
      end

    end
  end
end

at_exit do
  save_provider_files node_providers
end