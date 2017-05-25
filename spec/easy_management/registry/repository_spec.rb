require 'spec_helper'
require 'easy_management/registry/repository'
require 'easy_management/registry/record'

describe EasyManagement::Registry::Repository do

  let(:target) { 'namespace/model' }

  let(:options) { Hash.new key: :value }

  let(:repository) { EasyManagement::Registry::Repository.new }

  it { expect(repository.records).to eq [] }

  describe '#add' do

    before { repository.add target, options }

    it { expect(repository.records.count).to eq 1 }

    it { expect(repository.records.first.target).to eq target }

    it { expect(repository.records.first.options).to eq options }

  end

  describe '.singleton' do

    subject { EasyManagement::Registry::Repository.singleton }

    it { is_expected.to be_a EasyManagement::Registry::Repository }

  end

end