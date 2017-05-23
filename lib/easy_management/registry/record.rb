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
      end

      def manager
        self.helper.manager
      end

      def controller
        self.helper.controller
      end

    end

  end
end