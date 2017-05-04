require 'easy_management/registry/repository'

module EasyManagement

  class Routes

    class << self

      def draw
        repository.records.each { |r| setup_route r }
      end

      protected

      def repository
        EasyManagement::Registry::Repository.singleton
      end

      def setup_route(record)
        helper = record.helper
        model_namespace = helper.namespace ? helper.namespace.downcase : nil
        model_resource = helper.model_class.downcase.pluralize

        Rails.application.routes.draw do
          if model_namespace
            namespace model_namespace do
              resources model_resource
            end
          else
            resources model_resource
          end
        end
      end

    end

  end

end