source 'https://rubygems.org'

ruby '1.9.3'
#ruby-gemset=vagrant-provide-o-matic

# Specify your gem's dependencies in vagrant-butcher.gemspec
gemspec

group :development do
  # We depend on Vagrant for development, but we don't add it as a
  # gem dependency because we expect to be installed within the
  # Vagrant environment itself using `vagrant plugin`.
  gem "vagrant", :git => "git://github.com/mitchellh/vagrant.git"
end