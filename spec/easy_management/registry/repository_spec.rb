require 'spec_helper'
require 'easy_management/registry/repository'
require 'easy_management/registry/record'

describe EasyManagement::Registry::Repository do

  let(:model) { 'namespace/model' }

  let(:options) { Hash.new key: :value }

  let(:repository) { EasyManagement::Registry::Repository.new }

  it { expect(repository.records).to eq [] }

  describe '#add' do

    before { repository.add model, options }

    it { expect(repository.records.count).to eq 1 }

    it { expect(repository.records.first.model).to eq model }

    it { expect(repository.records.first.options).to eq options }

  end

  describe '#build_classes_for_all_records' do

    subject { repository.build_classes_for_all_records }

    before do
      repository.add model, options
      repository.records.each do |r|
        expect(r).to receive(:build_manager_class).ordered
        expect(r).to receive(:build_controller_class).ordered
      end
    end

    it { expect(repository.records.count).to(eq 1); subject }

  end

  describe '.singleton' do

    subject { EasyManagement::Registry::Repository.singleton }

    it { is_expected.to be_a EasyManagement::Registry::Repository }

  end

end