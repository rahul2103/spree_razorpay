module SpreeRazorpay
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root(File.expand_path(File.dirname(__FILE__)))
      class_option :migrate, type: :boolean, default: true

      def add_javascripts
        append_file 'vendor/assets/javascripts/spree/frontend/all.js', "//= require spree/frontend/spree_razorpay\n"
        append_file 'vendor/assets/javascripts/spree/frontend/all.js', "//= require spree/frontend/process_razorpay\n"
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_razorpay'
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