module EasyManagement
  module Helpers

    class ModelHelper

      attr_accessor :name

      def initialize(name)
        self.name = name.singularize.downcase
      end

      def namespace
        chain = underscored_name.split('/')[0..-2]
        chain.empty? ? nil : chain.join('/').classify
      end

      def controller_class
        "#{model_class.pluralize}Controller"
      end

      def manager_class
        "#{model_class.pluralize}Manager"
      end

      def model_class
        underscored_name.split('/').last.classify
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

    end

  end
end