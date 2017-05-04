require 'spec_helper'

describe EasyManagement do

  before { expect_any_instance_of(Gem::Specification).to receive(:gem_dir).and_return('dir') }

  subject { EasyManagement.management_templates_path }

  it { is_expected.to eq 'dir/lib/easy_management/templates' }

end