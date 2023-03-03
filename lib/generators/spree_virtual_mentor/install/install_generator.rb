module SpreeVirtualMentor
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root(File.expand_path(File.dirname(__FILE__)))
      class_option :migrate, type: :boolean, default: true

      def copy_initializer
        copy_file 'spree_open_ai.rb', 'config/initializers/spree_open_ai.rb'
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_virtual_mentor'
      end

      def run_migrations
        run_migrations = options[:migrate] || ['', 'y', 'Y'].include?(ask('Would you like to run the migrations now? [Y/n]'))
        if run_migrations
          run 'bundle exec rails db:migrate'
        else
          puts 'Skipping rails db:migrate, don\'t forget to run it!'
        end
      end
    end
  end
end
