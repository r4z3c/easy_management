require 'easy_management/errors/unauthorized_error'
require 'easy_management/errors/handled_record_invalid_error'
require 'action_controller/api'

module EasyManagement
  module Controllers

    class BaseController < ::ActionController::API

      rescue_from ::ActiveRecord::RecordInvalid, with: :rescue_from_record_invalid_error
      rescue_from ::ActiveRecord::RecordNotFound, with: :rescue_from_record_not_found_error
      rescue_from Errors::UnauthorizedError, with: :rescue_from_unauthorized_error
      rescue_from Errors::HandledRecordInvalidError, with: :rescue_from_handled_record_invalid_error

      before_action :append_templates_path

      def index
        @list = manager_instance.index permitted_params
      end

      def create
        @item = manager_instance.create! permitted_params
        head :created
      end

      def show
        @item = manager_instance.show params[:id]
      end

      def update
        @item = manager_instance.update params[:id], permitted_params
        head :ok
      end

      def destroy
        @item = manager_instance.destroy params[:id]
      end

      protected

      def rescue_from_record_invalid_error(e)
        render_error e.record.errors, :unprocessable_entity
      end

      def rescue_from_record_not_found_error(*)
        render_error nil, :not_found
      end

      def rescue_from_unauthorized_error(*)
        render_error nil, :forbidden
      end

      def rescue_from_handled_record_invalid_error(e)
        render_error({ messages: e.messages, errors: e.errors }, :unprocessable_entity)
      end

      def render_error(json, status)
        render json: json, status: status
      end

      def append_templates_path
        self.prepend_view_path EasyManagement.management_templates_path
      end

      def permitted_params
        send "permitted_params_on_#{current_action}"
      end

      def current_action
        params[:action]
      end

      def permitted_params_on_index
        model_params = params[model_name]

        permitted = {
          model_name => (model_params ? model_params.permit! : nil),
          options: params.permit(options: [:per_page, :page, :order])[:options] || {}
        }

        permitted
      end

      def permitted_params_on_create
        params.require(model_name).permit model.column_names
      end

      def permitted_params_on_update
        permitted_params_on_create
      end

      def model_name
        manager_instance.model_name
      end

      def model
        manager_instance.send :model
      end

      def manager_instance
        @manager ||= manager.new
      end

      def manager
        raise NotImplementedError.new("manager@#{self.class} must overwrite manager@#{self.class.superclass}")
      end

    end

  end
end