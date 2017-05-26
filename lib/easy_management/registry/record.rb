require 'model_builder'
require 'easy_management/helpers/model_helper'
require 'easy_management/managers/base_manager'
require 'easy_management/controllers/base_controller'
require 'easy_management/builders/manager_builder'
require 'easy_management/builders/controller_builder'

module EasyManagement
  module Registry

    class Record

      attr_accessor :model, :options, :helper, :manager, :controller

      def initialize(model, options={})
        self.model = model.to_s
        self.options = options
        self.helper = EasyManagement::Helpers::ModelHelper.new self.model
      end

      def manager
        self.helper.manager_constant
      end

      def controller
        self.helper.controller_constant
      end

      def build_manager_class
        manager_builder.build
      end

      def manager_builder
        @manager_builder ||= EasyManagement::Builders::ManagerBuilder.new self
      end

      def build_controller_class
        controller_builder.build
      end

      def controller_builder
        @controller_builder ||= EasyManagement::Builders::ControllerBuilder.new self
      end

    end

  end
end