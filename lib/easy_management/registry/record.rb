require 'model_builder'
require 'easy_management/helpers/model_helper'
require 'easy_management/managers/base_manager'
require 'easy_management/controllers/base_controller'

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

    end

  end
end