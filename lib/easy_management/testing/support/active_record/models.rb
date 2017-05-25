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

            def build_sample_model
              definitions = [
                'EasyManagement::Testing::Support::ActiveRecord::Sample',
                attributes: {
                  name: :string,
                  created_at: :datetime,
                },
                validates: [
                  [:name, presence: true]
                ]
              ]

              @sample_model ||= ModelBuilder.build *definitions
            end

          end

        end
      end
    end
  end
end