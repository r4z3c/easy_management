require 'spec_helper'
require 'easy_management/testing/support/active_record/models'
require 'easy_management/testing/support/active_record/dummies_manager'
require 'easy_management/testing/support/active_record/dummies_controller'

EasyManagement::Testing::Support::ActiveRecord::Models.build_dummy_model

describe EasyManagement::Helpers::ModelHelper do

  let(:helper) { EasyManagement::Helpers::ModelHelper.new 'easy_management/testing/support/active_record/dummy' }

  describe '#controller' do

    subject { helper.controller_constant }

    it { is_expected.to eq EasyManagement::Testing::Support::ActiveRecord::DummiesController }

    it { expect(subject.new.send :manager).to eq EasyManagement::Testing::Support::ActiveRecord::DummiesManager }

  end

  describe '#manager' do

    subject { helper.manager_constant }

    it { is_expected.to eq EasyManagement::Testing::Support::ActiveRecord::DummiesManager }

  end

  describe '#namespace' do

    subject { helper.namespace }

    it { is_expected.to eq 'EasyManagement::Testing::Support::ActiveRecord' }

  end

  describe '#controller_class' do

    subject { helper.controller_class }

    it { is_expected.to eq 'DummiesController' }

  end

  describe '#manager_class' do

    subject { helper.manager_class }

    it { is_expected.to eq 'DummiesManager' }

  end

  describe '#model_class' do

    subject { helper.model_class }

    it { is_expected.to eq 'Dummy' }

  end

  describe '#controller_path' do

    subject { helper.controller_path }

    it { is_expected.to eq 'app/controllers/easy_management/testing/support/active_record/dummies_controller.rb' }

  end

  describe '#manager_path' do

    subject { helper.manager_path }

    it { is_expected.to eq 'app/managers/easy_management/testing/support/active_record/dummies_manager.rb' }

  end

  describe '#model_path' do

    subject { helper.model_path }

    it { is_expected.to eq 'app/models/easy_management/testing/support/active_record/dummy.rb' }

  end

  describe '#underscored_model' do

    subject { helper.underscored_model }

    it { is_expected.to eq 'easy_management/testing/support/active_record/dummy' }

  end

  describe '#controllers_path' do

    subject { helper.controllers_path }

    it { is_expected.to eq 'app/controllers' }

  end

  describe '#managers_path' do

    subject { helper.managers_path }

    it { is_expected.to eq 'app/managers' }

  end

  describe '#models_path' do

    subject { helper.models_path }

    it { is_expected.to eq 'app/models' }

  end

  describe '#app_path' do

    subject { helper.app_path }

    it { is_expected.to eq 'app' }

  end

end