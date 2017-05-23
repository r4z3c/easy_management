module EasyManagement
  module Helpers

    class ModelHelper

      attr_accessor :name, :manager, :controller

      def initialize(name)
        self.name = name.to_s.singularize.downcase
        setup
      end

      def namespace
        chain = underscored_name.split('/')[0..-2]
        chain.empty? ? nil : chain.join('/').camelize
      end

      def controller_class
        "#{model_class.pluralize}Controller"
      end

      def manager_class
        "#{model_class.pluralize}Manager"
      end

      def model_class
        underscored_name.split('/').last.camelize
      end

      def controller_path
        "#{controllers_path}/#{underscored_name.pluralize}_controller.rb"
      end

      def manager_path
        "#{managers_path}/#{underscored_name.pluralize}_manager.rb"
      end

      def model_path
        "#{models_path}/#{underscored_name}.rb"
      end

      def underscored_name
        name.underscore
      end

      def controllers_path
        "#{app_path}/controllers"
      end

      def managers_path
        "#{app_path}/managers"
      end

      def models_path
        "#{app_path}/models"
      end

      def app_path
        'app'
      end

      protected

      def setup
        @manager ||= create_manager
        @controller ||= create_controller
      end

      def create_manager
        manager_class_str = "#{namespace}::#{self.manager_class}"

        manager_class = create_class manager_class_str, EasyManagement::Managers::BaseManager

        model_class = underscored_name.classify.constantize

        manager_class.send :define_method, :model do
          model_class
        end

        model_class_sym = self.model_class.downcase.to_sym

        manager_class.send :define_method, :model_name do
          model_class_sym
        end

        manager_class
      end

      def create_controller
        controller_class_str = "#{namespace}::#{self.controller_class}"

        controller_class = create_class controller_class_str, EasyManagement::Controllers::BaseController

        manager_class = @manager

        controller_class.send :define_method, :manager do
          manager_class
        end

        controller_class
      end

      def create_class(full_name, superclass)
        ModelBuilder::ClassBuilder.build full_name, superclass: superclass
      end

    end

  end
end