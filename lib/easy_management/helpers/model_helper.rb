require 'easy_management/builders/manager_builder'
require 'easy_management/builders/controller_builder'

module EasyManagement
  module Helpers

    class ModelHelper

      attr_accessor :model

      def initialize(model)
        self.model = model.to_s.singularize.downcase
      end

      def controller_constant
        "#{namespace}::#{controller_class}".constantize
      end

      def manager_constant
        "#{namespace}::#{manager_class}".constantize
      end

      def model_constant
        "#{namespace}::#{model_class}".constantize
      end

      def model_symbol
        model_class.downcase.to_sym
      end

      def namespace
        chain = underscored_model.split('/')[0..-2]
        chain.empty? ? nil : chain.join('/').camelize
      end

      def controller_class
        "#{model_class.pluralize}Controller"
      end

      def manager_class
        "#{model_class.pluralize}Manager"
      end

      def model_class
        underscored_model.split('/').last.camelize
      end

      def controller_path
        "#{controllers_path}/#{underscored_model.pluralize}_controller.rb"
      end

      def manager_path
        "#{managers_path}/#{underscored_model.pluralize}_manager.rb"
      end

      def model_path
        "#{models_path}/#{underscored_model}.rb"
      end

      def underscored_model
        model.underscore
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

    end

  end
end