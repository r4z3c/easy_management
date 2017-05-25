require 'spec_helper'
require 'easy_management/builders/manager_builder'
require 'easy_management/testing/support/active_record/models'

EasyManagement::Testing::Support::ActiveRecord::Models.build_sample_model

describe EasyManagement::Builders::ManagerBuilder do

  let(:model_name) { 'easy_management/testing/support/active_record/sample' }

  let(:builder) { EasyManagement::Builders::ManagerBuilder.new model_name }

  before { builder.build }

  it { expect(builder.model_name).to eq model_name }

  it { expect(builder.klass).to eq EasyManagement::Testing::Support::ActiveRecord::SamplesManager }

  it { expect(builder.klass.new.send :model_name).to eq :sample }

  it { expect(builder.klass.new.send :model).to eq EasyManagement::Testing::Support::ActiveRecord::Sample }

end