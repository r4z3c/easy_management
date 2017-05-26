require 'spec_helper'
require 'easy_management/builders/manager_builder'
require 'easy_management/testing/support/active_record/models'

EasyManagement::Testing::Support::ActiveRecord::Models.build_sample_model

describe EasyManagement::Builders::ManagerBuilder do

  let(:model) { 'easy_management/testing/support/active_record/sample' }

  let(:record) { EasyManagement::Registry::Record.new model }

  let(:builder) { EasyManagement::Builders::ManagerBuilder.new record }

  before { builder.build }

  it { expect(builder.record).to eq record }

  it { expect(builder.klass).to eq EasyManagement::Testing::Support::ActiveRecord::SamplesManager }

  it { expect(builder.klass.new.send :model_name).to eq :sample }

  it { expect(builder.klass.new.send :model).to eq EasyManagement::Testing::Support::ActiveRecord::Sample }

end