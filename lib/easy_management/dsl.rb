module EasyManagement

  class Dsl

    def manage(model, options={})
      self.repository.add model, options
    end

    protected

    def repository
      self.class.repository
    end

    class << self

      def configure(&block)
        self.new.instance_eval(&block)
        self.repository.build_classes_for_all_records
      end

      def repository
        EasyManagement::Registry::Repository.singleton
      end

    end

  end

end