module Vagrant
  module ProvideOMatic
    class Env
      attr_accessor :ui

      def initialize
        if Gem::Version.new(::Vagrant::VERSION) >= Gem::Version.new("1.2")
          @ui = ::Vagrant::UI::Colored.new.scope('ProvideOMatic')
        else
          @ui = ::Vagrant::UI::Colored.new('ProvideOMatic')
        end
      end
    end
  end
end