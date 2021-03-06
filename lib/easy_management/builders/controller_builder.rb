require 'easy_management/builders/class_builder'

module EasyManagement
  module Builders

    class ControllerBuilder < ClassBuilder

      protected

      def class_full_name
        "#{model_helper.namespace}::#{model_helper.controller_class}"
      end

      def superclass
        EasyManagement::Controllers::BaseController
      end

      def setup_class
        manager_class = model_helper.manager_constant

        manager_method = Proc.new { manager_class }

        self.klass.send :define_method, :manager, manager_method
      end

    end

  end
end