require 'spec_helper'
require 'easy_management/errors/unauthorized_error'

describe EasyManagement::Errors::UnauthorizedError do

  let(:error) { EasyManagement::Errors::UnauthorizedError }

  it { expect(error.superclass).to eq StandardError }

end