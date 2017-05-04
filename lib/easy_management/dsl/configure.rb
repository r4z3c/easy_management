require 'easy_management/dsl/manage'

module EasyManagement
  module Dsl

    class Configure

      attr_accessor

      def manage(*args, &block)
        EasyManagement::Dsl::Manage.new *args, &block
      end

    end

  end
end