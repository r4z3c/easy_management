require 'rails/generators'
require 'easy_management/helpers/model_helper'

module EasyManagement
  module Generators

    class ManageGenerator < Rails::Generators::Base

      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
      argument :model, type: :string, required: true, desc: 'The model name - e.g: `rail g manager company` or `rails g manager auth/user`'
      class_option :file, type: :boolean, required: false, desc: 'Will create `manager` and `controller` files'

      def create_manage_config
        raise "`#{model}` model not found" unless File.exist? helper.model_path

        manage = "manage '#{helper.name.pluralize}'"
        configure = 'EasyManagement::Dsl.configure'

        system "grep -q \"#{manage}\" ./app/managers/config.rb || sed -ir \"/#{configure}/ a\\  #{manage}\" ./app/managers/config.rb"
      end

      def create_manager_file
        template 'manager.rb.erb', helper.manager_path if options[:file]
      end

      def create_controller_file
        template 'controller.rb.erb', helper.controller_path if options[:file]
      end

      protected

      def helper
        @helper ||= EasyManagement::Helpers::ModelHelper.new model
      end

      def namespace_open
        helper.namespace ? "module #{helper.namespace}" : ''
      end

      def manager_class_open
        "class #{helper.manager_class} < ::EasyManagement::Managers::BaseManager"
      end

      def controller_class_open
        "class #{helper.controller_class} < ::EasyManagement::Controllers::BaseController"
      end

      def class_close
        'end'
      end

      def namespace_close
        helper.namespace ? 'end' : ''
      end

    end

  end
end