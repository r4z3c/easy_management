require 'easy_management/controllers/base_controller'
require 'easy_management/testing/support/active_record/dummies_manager'

module EasyManagement
  module Testing
    module Support
      module ActiveRecord

        class DummiesController < EasyManagement::Controllers::BaseController

          protected

          def manager
            EasyManagement::Testing::Support::ActiveRecord::DummiesManager
          end

        end

      end
    end
  end
end