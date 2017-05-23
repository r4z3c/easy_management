require 'model_builder'

module EasyManagement
  module Testing
    module Support
      module ActiveRecord
        module Models

          class << self

            def build_dummy_model
              definitions = [
                  'EasyManagement::Testing::Support::ActiveRecord::Dummy',
                  attributes: {
                      name: :string,
                      created_at: :datetime,
                  },
                  validates: [
                      [:name, presence: true]
                  ]
              ]

              @dummy_model ||= ModelBuilder.build *definitions
            end

          end

        end
      end
    end
  end
end