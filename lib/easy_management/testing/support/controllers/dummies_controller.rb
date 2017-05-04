require 'easy_management/controllers/base_controller'
require 'easy_management/testing/support/managers/dummies_manager'

module EasyManagement
  module Testing
    module Support
      module Controllers

        class DummiesController < EasyManagement::Controllers::BaseController

          protected

          def manager
            EasyManagement::Testing::Support::Managers::DummiesManager
          end

        end

      end
    end
  end
end