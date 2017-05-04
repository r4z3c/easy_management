module EasyManagement
  module Errors

    class HandledRecordInvalidError < StandardError

      attr_accessor :messages, :errors

      def initialize(*args)
        self.messages = args[0] || []
        self.errors = args[1] || {}
        super 'HandledRecordInvalidError'
      end

    end

  end
end