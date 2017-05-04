require 'easy_management/dsl/configure'

module EasyManagement
  module Dsl

    def self.configure(&block)
      EasyManagement::Dsl::Configure.new.instance_eval &block
    end

  end
end