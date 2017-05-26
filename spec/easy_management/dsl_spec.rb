require 'spec_helper'
require 'easy_management/testing/support/active_record/dummies_controller'
require 'easy_management/testing/support/active_record/dummies_manager'
require 'easy_management/testing/support/active_record/models'

EasyManagement::Testing::Support::ActiveRecord::Models.build_dummy_model
EasyManagement::Testing::Support::ActiveRecord::Models.build_sample_model

describe EasyManagement::Dsl do

  let(:dsl) { EasyManagement::Dsl }

  let(:record) { EasyManagement::Registry::Repository.singleton.records.select { |r| r.model.eql? model }.first }

  describe '.configure' do

    context 'simple management' do

      let(:model) { 'easy_management/testing/support/active_record/dummy' }

      before do
        expect(dsl.repository).to receive(:build_classes_for_all_records)
        dsl.configure { manage 'easy_management/testing/support/active_record/dummy' }
      end

      it { expect(record).to be }

      it { expect(record.model).to eq model }

      it { expect(record.options).to eq Hash.new }

      it { expect(record.helper.model).to eq model }

      it { expect(record.manager).to eq EasyManagement::Testing::Support::ActiveRecord::DummiesManager }

      it { expect(record.controller).to eq EasyManagement::Testing::Support::ActiveRecord::DummiesController }

      it { expect(record.controller.new.send :manager).to eq EasyManagement::Testing::Support::ActiveRecord::DummiesManager }

    end

    context 'custom management' do

      let(:model) { 'easy_management/testing/support/active_record/sample' }

      let(:options) { { only: :index } }

      before { dsl.configure { manage 'easy_management/testing/support/active_record/sample', only: :index } }

      it { expect(record).to be }

      it { expect(record.model).to eq model }

      it { expect(record.options).to eq options }

      it { expect(record.helper.model).to eq model }

      it { expect(record.manager).to eq EasyManagement::Testing::Support::ActiveRecord::SamplesManager }

      it { expect(record.controller).to eq EasyManagement::Testing::Support::ActiveRecord::SamplesController }

      it { expect(record.controller.new.send :manager).to eq EasyManagement::Testing::Support::ActiveRecord::SamplesManager }


    end

  end

end