require 'easy_management/builders/class_builder'

module EasyManagement
  module Builders

    class ManagerBuilder < ClassBuilder

      protected

      def class_full_name
        "#{model_helper.namespace}::#{model_helper.manager_class}"
      end

      def superclass
        EasyManagement::Managers::BaseManager
      end

      def setup_class
        model_class = model_helper.underscored_model.classify.constantize
        model_class_sym = model_helper.model_class.downcase.to_sym

        self.klass.send :define_method, :model do
          model_class
        end

        self.klass.send :define_method, :model_name do
          model_class_sym
        end
      end

    end

  end
end