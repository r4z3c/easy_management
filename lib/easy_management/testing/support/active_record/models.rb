require 'model_builder'

module EasyManagement
  module Testing
    module Support
      module ActiveRecord
        module Models

          class << self

            def build_dummy_model
              @dummy_model ||= build_common_model 'Dummy'
            end

            def build_sample_model
              @sample_model ||= build_common_model 'Sample'
            end

            def build_common_model(model_class)
              definitions = [
                "EasyManagement::Testing::Support::ActiveRecord::#{model_class}",
                attributes: {
                  name: :string,
                  created_at: :datetime,
                },
                validates: [
                  [:name, presence: true]
                ]
              ]

              ModelBuilder.build(*definitions)
            end

          end

        end
      end
    end
  end
end