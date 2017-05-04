require 'easy_management/registry/record'

module EasyManagement
  module Registry

    class Repository

      attr_accessor :records

      def initialize(records = [])
        self.records = records
      end

      def add(target, options={})
        self.records.push EasyManagement::Registry::Record.new(target, options)
      end

      class << self

        def singleton
          @singleton ||= Repository.new
        end

      end

    end

  end
end