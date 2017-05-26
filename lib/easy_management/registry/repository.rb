require 'easy_management/registry/record'

module EasyManagement
  module Registry

    class Repository

      attr_accessor :records

      def initialize(records = [])
        self.records = records
      end

      def add(model, options={})
        self.records.push EasyManagement::Registry::Record.new(model, options)
      end

      def build_classes_for_all_records
        records.each { |r| r.build_manager_class; r.build_controller_class }
      end

      class << self

        def singleton
          @singleton ||= Repository.new
        end

      end

    end

  end
end