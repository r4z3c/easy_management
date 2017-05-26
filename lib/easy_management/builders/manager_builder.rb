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
        model_class = model_helper.model_constant
        model_class_sym = model_helper.model_symbol

        model_method = Proc.new { model_class }
        model_name_method = Proc.new { model_class_sym }

        self.klass.send :define_method, :model, &model_method
        self.klass.send :define_method, :model_name, &model_name_method
      end

    end

  end
end