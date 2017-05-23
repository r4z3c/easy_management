require 'spec_helper'
require 'easy_management/controllers/base_controller'
require 'easy_management/testing/support/active_record/dummies_controller'

EasyManagement::Testing::Support::ActiveRecord::Models.build_dummy_model

describe EasyManagement::Controllers::BaseController, type: :api do

  let(:model) { EasyManagement::Testing::Support::ActiveRecord::Dummy }

  let(:controller) { EasyManagement::Testing::Support::ActiveRecord::DummiesController.new }

  let(:base_controller) { EasyManagement::Controllers::BaseController.new }

  let(:manager) { controller.send :manager_instance }

  context 'common methods' do
    describe '#model_name' do
      context 'when not overwritten' do
        it { expect{base_controller.send :model_name}.to raise_error(NotImplementedError) }
      end
    end

    context 'permitted_params' do
      let(:params_dbl) { double }
      let(:required_dbl) { double }

      before {
        expect(controller).to receive(:params).and_return params_dbl
        expect(params_dbl).to receive(:require).with(controller.send :model_name).and_return required_dbl
        expect(required_dbl).to receive(:permit).with(model.column_names).and_return :permitted_params
      }

      subject { controller.send permitted_params_method }

      describe '#permitted_params_on_create' do
        let(:permitted_params_method) { :permitted_params_on_create }

        it { is_expected.to eq :permitted_params }
      end

      describe '#permitted_params_on_update' do
        let(:permitted_params_method) { :permitted_params_on_update }

        it { is_expected.to eq :permitted_params }
      end
    end

    describe '#append_templates_path' do
      before { expect(controller).to receive(:append_view_path).with(EasyManagement.management_templates_path) }
      before { skip 'find a way to test this' }

      subject { controller.send :append_templates_path }

      it { is_expected }
    end

    context 'error handlers' do
      let(:record) { model.new }

      subject { controller.send error_handler, *handler_args }

      describe '#rescue_from_record_invalid_error' do
        before { record.valid? }

        let(:error_handler) { :rescue_from_record_invalid_error }

        let(:handler_args) { [ActiveRecord::RecordInvalid.new(record)] }

        let(:render_error_args) { [
          :bad_request,
          ["Validation failed: Name can't be blank"],
          { name: ["can't be blank"] }
        ] }

        it { render_error_spec }
      end

      describe '#rescue_from_record_not_found_error' do
        let(:error_handler) { :rescue_from_record_not_found_error }

        let(:handler_args) { [nil] }

        let(:render_error_args) { [
            :not_found,
            ['not found']
        ] }

        it { render_error_spec }
      end

      describe '#rescue_from_unauthorized_error' do
        let(:error_handler) { :rescue_from_unauthorized_error }

        let(:handler_args) { [EasyManagement::Errors::UnauthorizedError.new] }

        let(:render_error_args) { [
            :forbidden,
            %w(forbidden)
        ] }

        it { render_error_spec }
      end

      describe '#rescue_from_handled_record_invalid_error' do
        let(:error_handler) { :rescue_from_handled_record_invalid_error }

        let(:handler_args) { [EasyManagement::Errors::HandledRecordInvalidError.new(:messages, :errors)] }

        let(:render_error_args) { [
            :bad_request,
            :messages,
            :errors
        ] }

        it { render_error_spec }
      end

      describe '#render_error' do
        let(:error_handler) { :render_error }

        let(:handler_args) { [:status, :messages, :errors] }

        let(:spec) { {
          json: {
            status: :error,
            messages: :messages,
            errors: :errors
          },
          status: :status
        } }

        it { expect(controller).to receive(:render).with(spec) ; subject }
      end

      def render_error_spec
        expect(controller).to receive(:render_error).with(*render_error_args) ; subject
      end
    end
  end

  context 'action methods' do
    describe 'POST #create' do
      let(:create_params) do
        ActionController::Parameters.new({
          action: :create,
          dummy: {
            name: :name
          }
        })
      end

      subject { controller.create }

      it do
        expect(controller).to receive(:params).and_return(create_params).at_least(:once)

        expect(manager.find_by name: :name).to_not be

        expect { subject }.to change { model.count }.by(1)
      end
    end

    describe 'GET #index' do
      before { 10.times { |i| manager.create! name: "name#{i}" } }

      let(:model_params) { nil }

      let(:option_params) { nil }

      let(:index_params) do
        ActionController::Parameters.new({
          action: :index,
          dummy: model_params,
          options: option_params
        })
      end

      before {
        expect(controller).to receive(:params).and_return(index_params).at_least(:once)
        controller.index
        @list = controller.instance_variable_get :@list
      }

      context 'when non paginated result without filter' do
        it { expect(@list.length).to eq 10 }

        it { expect(@list[0].name).to eq 'name0' }
      end

      context 'when non paginated result with filter' do
        let(:model_params) { { name: :name5 } }

        it { expect(@list.length).to eq 1 }

        it { expect(@list[0].name).to eq 'name5' }
      end

      context 'when paginated result' do
        let(:model_params) { nil }

        let(:option_params) { { per_page: 3, page: 3, order: 'name desc' } }

        it { expect(@list.length).to eq 3 }

        it { expect(@list.last.name).to eq 'name1' }
      end
    end

    describe 'GET #show' do
      let!(:existing) { manager.create! name: :name }

      let(:show_params) { ActionController::Parameters.new id: existing.id }

      before {
        expect(controller).to receive(:params).and_return(show_params).at_least(1)
        controller.show
      }

      it { expect(controller.instance_variable_get(:@item).name).to eq 'name' }
    end

    describe 'PUT #update' do
      let(:update_params) do
        ActionController::Parameters.new({
          action: :update,
          id: existing.id,
          dummy: { name: :hue }
        })
      end

      before { expect(controller).to receive(:params).and_return(update_params).at_least(1) }

      subject { controller.update }

      context 'when resource exists' do
        let!(:existing) { manager.create! name: :name }

        it do
          expect(existing.name).to eq 'name'

          subject; existing.reload

          expect(existing.name).to eq 'hue'
        end
      end
    end

    describe 'DELETE #destroy' do
      let!(:existing) { manager.create! name: :name }

      let(:destroy_params) { ActionController::Parameters.new id: existing.id }

      subject { controller.destroy }

      it do
        expect(controller).to receive(:params).and_return(destroy_params).at_least(1)

        subject

        expect { manager.find existing.id }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

end