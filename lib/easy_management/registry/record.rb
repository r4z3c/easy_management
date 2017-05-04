require 'model_builder'
require 'easy_management/helpers/model_helper'
require 'easy_management/managers/base_manager'
require 'easy_management/controllers/base_controller'

module EasyManagement
  module Registry

    class Record

      attr_accessor :target, :options, :helper, :manager, :controller

      def initialize(target, options={})
        self.target = target.to_s
        self.options = options
        self.helper = EasyManagement::Helpers::ModelHelper.new self.target

        setup
      end

      def setup
        @manager ||= create_manager
        @controller ||= create_controller
      end

      def create_manager
        manager_class = "#{helper.namespace}::#{helper.manager_class}"

        manager = create_class manager_class, EasyManagement::Managers::BaseManager

        model_class = helper.underscored_name.classify.constantize

        manager.send :define_method, :model do
          model_class
        end

        model_class_sym = helper.model_class.downcase.to_sym

        manager.send :define_method, :model_name do
          model_class_sym
        end

        manager
      end

      def create_controller
        controller_class = "#{helper.namespace}::#{helper.controller_class}"

        controller = create_class controller_class, EasyManagement::Controllers::BaseController

        manager_class = @manager

        controller.send :define_method, :manager do
          manager_class
        end

        controller
      end

      def create_class(full_name, superclass)
        ModelBuilder::ClassBuilder.build full_name, superclass: superclass
      end

    end

  end
end