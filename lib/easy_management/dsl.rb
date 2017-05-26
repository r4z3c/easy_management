module EasyManagement

  class Dsl

    def manage(model, options={})
      self.repository.add model, options
    end

    protected

    def repository
      @repository ||= EasyManagement::Registry::Repository.singleton
    end

    class << self

      def configure(&block)
        self.new.instance_eval(&block)
      end

    end

  end

end