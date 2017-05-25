require 'model_builder'

module EasyManagement
  module Builders

    class ClassBuilder

      attr_accessor :model_name, :klass

      def initialize(model_name)
        self.model_name = model_name
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
        @model_helper ||= EasyManagement::Helpers::ModelHelper.new model_name
      end

    end

  end
end