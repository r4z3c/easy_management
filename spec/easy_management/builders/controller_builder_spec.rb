require 'spec_helper'
require 'easy_management/builders/manager_builder'
require 'easy_management/builders/controller_builder'
require 'easy_management/testing/support/active_record/models'

EasyManagement::Testing::Support::ActiveRecord::Models.build_sample_model

describe EasyManagement::Builders::ManagerBuilder do

  let(:model) { 'easy_management/testing/support/active_record/sample' }

  let(:record) { EasyManagement::Registry::Record.new model }

  let(:builder) { EasyManagement::Builders::ControllerBuilder.new record }

  before { EasyManagement::Builders::ManagerBuilder.new(record).build }

  before { builder.build }

  it { expect(builder.record).to eq record }

  it { expect(builder.klass).to eq EasyManagement::Testing::Support::ActiveRecord::SamplesController }

  it { expect(builder.klass.new.send :manager).to eq EasyManagement::Testing::Support::ActiveRecord::SamplesManager }

end