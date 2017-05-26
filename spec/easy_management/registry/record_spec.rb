require 'spec_helper'
require 'easy_management/registry/record'
require 'easy_management/helpers/model_helper'
require 'easy_management/builders/manager_builder'
require 'easy_management/builders/controller_builder'

describe EasyManagement::Registry::Record do

  let(:model) { 'namespace/model' }

  let(:options) { Hash.new key: :value }

  let(:record) { EasyManagement::Registry::Record.new model, options  }

  it { expect(record.model).to eq model }

  it { expect(record.options).to eq options }

  it { expect(record.helper).to be_a EasyManagement::Helpers::ModelHelper }

  it { expect(record.helper.model).to eq model }

  describe '#manager' do

    before { expect(record.helper).to receive(:manager_constant).and_return true }

    subject { record.manager }

    it { is_expected.to be_truthy }

  end

  describe '#controller' do

    before { expect(record.helper).to receive(:controller_constant).and_return true }

    subject { record.controller }

    it { is_expected.to be_truthy }

  end

  describe '#build_manager_class' do

    subject { record.build_manager_class }

    before { expect(record.manager_builder).to receive(:build).and_return(true) }

    it { is_expected.to be_truthy }

  end

  describe '#manager_builder' do

    subject { record.manager_builder }

    it { is_expected.to be_a EasyManagement::Builders::ManagerBuilder }

    it { expect(subject.record).to be record }

  end

  describe '#build_controller_class' do

    subject { record.build_controller_class }

    before { expect(record.controller_builder).to receive(:build).and_return(true) }

    it { is_expected.to be_truthy }

  end

  describe '#controller_builder' do

    subject { record.controller_builder }

    it { is_expected.to be_a EasyManagement::Builders::ControllerBuilder }

    it { expect(subject.record).to be record }

  end

end