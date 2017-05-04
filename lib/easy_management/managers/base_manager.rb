require 'kaminari'

module EasyManagement
  module Managers

    class BaseManager

      def index(attributes)
        all attributes[model_name.to_sym], attributes[:options]
      end

      def all(filter, options)
        order = options[:order]
        per_page = options[:per_page]
        page = options[:page] || 0

        column_names = model.column_names

        order ||= 'name asc' if column_names.include? 'name'
        order ||= 'created_at desc' if column_names.include? 'created_at'
        query = filter ? model.where(filter) : model

        query = query.order order if order
        query = query.page page if page
        query = query.per per_page if page and per_page

        filter ? query.to_a : query.all
      end

      def create(attributes)
        model.create attributes
      end

      def create!(attributes)
        model.create! attributes
      end

      def find(id)
        model.find id
      end

      def find_by(*args, &block)
        model.find_by(*args, &block)
      end

      def update(id, attributes)
        model.update id, attributes
      end

      def destroy(id)
        model.destroy id
      end

      def model_name
        raise NotImplementedError.new("model_name@#{self.class} must overwrite model_name@#{self.class.superclass}")
      end

      alias_method :show, :find

      protected

      def model
        raise NotImplementedError.new("model@#{self.class} must overwrite model@#{self.class.superclass}")
      end

    end

  end
end