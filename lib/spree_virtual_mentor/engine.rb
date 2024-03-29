module SpreeVirtualMentor
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_virtual_mentor'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer 'spree_virtual_mentor.environment', before: 'spree.environment' do |app|
      require File.join(File.dirname(__FILE__), '../../app/models/spree_virtual_mentor/configuration.rb')
    end

    initializer 'spree_virtual_mentor.environment', before: :load_config_initializers do |_app|
      SpreeVirtualMentor::Config = SpreeVirtualMentor::Configuration.new
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare(&method(:activate).to_proc)
  end
end
