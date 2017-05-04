require 'easy_management/registry/repository'

module EasyManagement
  module Dsl

    class Manage

      attr_accessor :repository

      def initialize(target, options={})
        self.repository = EasyManagement::Registry::Repository.singleton
        self.repository.add target, options
      end

    end

  end
end