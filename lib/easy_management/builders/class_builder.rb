require 'model_builder'

module EasyManagement
  module Builders

    class ClassBuilder

      attr_accessor :record, :klass

      def initialize(record)
        self.record = record
      end

      def build
        self.klass = create_class
        setup_class
        self.klass
      end

      protected

      def create_class
        ModelBuilder::ClassBuilder.build class_full_name, superclass: superclass
      end

      def class_full_name
        raise NotImplementedError.new("#{self.class.superclass}#class_full_name must be overwritten")
      end

      def superclass
        raise NotImplementedError.new("#{self.class.superclass}#superclass must be overwritten")
      end

      def setup_class
        raise NotImplementedError.new("#{self.class.superclass}#setup_class must be overwritten")
      end

      def model_helper
        record.helper
      end

    end

  end
end