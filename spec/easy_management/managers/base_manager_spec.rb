require 'spec_helper'
require 'easy_management/testing/support/models'
require 'easy_management/managers/base_manager'
require 'easy_management/testing/support/managers/dummies_manager'

EasyManagement::Testing::Support::Models.build_dummy_model

describe EasyManagement::Managers::BaseManager do

  let(:model) { EasyManagement::Testing::Support::Models::Dummy }

  let(:manager) { EasyManagement::Testing::Support::Managers::DummiesManager.new }

  let(:base_manager) { EasyManagement::Managers::BaseManager.new }

  let(:attributes) { { name: :name } }

  context 'common methods' do
    describe '#model_name' do
      context 'when not overwritten' do
        it { expect{base_manager.model_name}.to raise_error(NotImplementedError) }
      end
    end

    describe '#model' do
      context 'when not overwritten' do
        it { expect{base_manager.send :model}.to raise_error(NotImplementedError) }
      end
    end
  end

  context 'creation methods' do
    describe '#create' do
      subject { manager.create attributes }

      it { expect(model).to(receive(:create).with(attributes)); subject }
    end

    describe '#create!' do
      subject { manager.create! attributes }

      it { expect(model).to(receive(:create!).with(attributes)); subject }
    end
  end

  context 'changing methods' do
    let(:existing) { manager.create! name: :name }

    describe '#update' do
      subject { manager.update existing.id, existing.attributes }

      it do
        expect(model).to(receive(:update).with(existing.id, existing.attributes))
        subject
      end
    end

    describe '#destroy' do
      subject { manager.destroy existing.id }

      it { expect(model).to(receive(:destroy).with(existing.id)); subject }
    end
  end

  context 'reading methods' do
    let(:existing) { manager.create! name: :name }

    describe '#find' do
      subject { manager.find existing.id }

      it { expect(model).to(receive(:find).with(existing.id)); subject }
    end

    describe '#find_by' do
      subject { manager.find_by existing.attributes }

      it { expect(model).to(receive(:find_by).with(existing.attributes)); subject }
    end

    describe '#index' do
      subject { manager.index(dummy: :filter, options: :options) }

      it { expect(manager).to(receive(:all).with(:filter, :options)); subject }
    end

    describe '#all' do
      subject { manager.all filter, options }

      let(:filter) { nil }

      let(:options) { { } }

      context 'when given a order' do
        let(:options) { { order: :name } }

        it { expect(model).to(receive(:order).with(:name).and_return(model)); subject }
      end

      context 'when order not given' do
        context 'when model has `name` column' do
          it { expect(model).to(receive(:order).with('name asc').and_return(model)); subject }
        end

        context 'when model does not have `name` column, but has `created_at` column' do
          before { expect(model).to receive(:column_names).and_return(%w(created_at)) }

          it { expect(model).to(receive(:order).with('created_at desc').and_return(model)); subject }
        end
      end

      context 'when given a per_page and a page' do
        before { skip 'find a way to test this' }

        let(:options) { { per_page: 123, page: 1 } }

        it { expect_any_instance_of(EasyManagement::Testing::Support::Models::Dummy::ActiveRecord_Relation).to(receive(:per).with(123).and_return(model)); subject }
      end

      context 'when per_page not given' do
        it { expect(model).to_not receive :per; subject }
      end

      context 'when given a page' do
        let(:options) { { page: 123 } }

        it { expect(model).to receive(:page).with(123).and_return(model); subject }
      end

      context 'when page not given' do
        it { expect(model).to receive(:page).with(0).and_return(model); subject }
      end

      context 'when given a filter' do
        let(:filter) { { name: :name } }

        it { expect(model).to receive(:where).with(filter).and_return(model); subject }
      end

      context 'when filter not given' do
        it { expect(model).to_not receive(:where); subject }
      end
    end
  end

end