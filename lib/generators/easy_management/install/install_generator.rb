require 'rails/generators'

module EasyManagement
  module Generators

    class InstallGenerator < Rails::Generators::Base

      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

      def install
        Dir.mkdir managers_path unless Dir.exist? managers_path
        template 'config.rb.erb', "#{managers_path}/config.rb"
        template 'initializer.rb.erb', 'config/initializers/management.rb'
      end

      def insert_router
        req = "require 'easy_management/routes'"
        draw = 'EasyManagement::Routes.draw'
        rails_draw = 'Rails.application.routes.draw'

        system "grep -q \"#{req}\" ./config/routes.rb || sed -i \"1 i\\#{req}\\n\" ./config/routes.rb"
        system "grep -q '#{draw}' ./config/routes.rb || sed -ir '/#{rails_draw}/ a\\\\n  #{draw}' ./config/routes.rb"
      end

      protected

      def managers_path
        @managers_path ||= 'app/managers'
      end

    end

  end
end
