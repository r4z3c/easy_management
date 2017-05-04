require 'easy_management/managers/base_manager'
require 'easy_management/testing/support/models'

module EasyManagement
  module Testing
    module Support
      module Managers

        class DummiesManager < EasyManagement::Managers::BaseManager

          def model_name
            :dummy
          end

          protected

          def model
            EasyManagement::Testing::Support::Models.build_dummy_model
          end

        end

      end
    end
  end
end