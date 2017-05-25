require 'spec_helper'
require 'easy_management/builders/manager_builder'
require 'easy_management/builders/controller_builder'
require 'easy_management/testing/support/active_record/models'

EasyManagement::Testing::Support::ActiveRecord::Models.build_sample_model

describe EasyManagement::Builders::ManagerBuilder do

  let(:model_name) { 'easy_management/testing/support/active_record/sample' }

  let(:builder) { EasyManagement::Builders::ControllerBuilder.new model_name }

  before { EasyManagement::Builders::ManagerBuilder.new(model_name).build }

  before { builder.build }

  it { expect(builder.model_name).to eq model_name }

  it { expect(builder.klass).to eq EasyManagement::Testing::Support::ActiveRecord::SamplesController }

  it { expect(builder.klass.new.send :manager).to eq EasyManagement::Testing::Support::ActiveRecord::SamplesManager }

end