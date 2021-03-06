require 'spec_helper'
require 'easy_management/builders/class_builder'

describe EasyManagement::Builders::ClassBuilder do

  let(:record) { EasyManagement::Registry::Record.new 'model_name' }

  let(:builder) { EasyManagement::Builders::ClassBuilder.new record }

  describe '#class_full_name' do

    it { expect{ builder.send :class_full_name }.to raise_error(NotImplementedError) }

  end

  describe '#superclass' do

    it { expect{ builder.send :superclass }.to raise_error(NotImplementedError) }

  end

  describe '#setup_class' do

    it { expect{ builder.send :setup_class }.to raise_error(NotImplementedError) }

  end

end