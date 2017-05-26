require 'spec_helper'
require 'easy_management/testing/support/active_record/dummies_controller'
require 'easy_management/testing/support/active_record/dummies_manager'
require 'easy_management/testing/support/active_record/models'

EasyManagement::Testing::Support::ActiveRecord::Models.build_dummy_model

describe EasyManagement::Dsl do

  let(:dsl) { EasyManagement::Dsl }

  let(:record) { EasyManagement::Registry::Repository.singleton.records.first }

  let(:model) { 'easy_management/testing/support/active_record/dummy' }

  describe '.configure' do

    before { dsl.configure { manage 'easy_management/testing/support/active_record/dummy' } }

    it { expect(record).to be }

    it { expect(record.model).to eq model }

    it { expect(record.options).to eq Hash.new }

    it { expect(record.helper.model).to eq model }

    it { expect(record.manager).to eq EasyManagement::Testing::Support::ActiveRecord::DummiesManager }

    it { expect(record.controller).to eq EasyManagement::Testing::Support::ActiveRecord::DummiesController }

    it { expect(record.controller.new.send :manager).to eq EasyManagement::Testing::Support::ActiveRecord::DummiesManager }

  end

end