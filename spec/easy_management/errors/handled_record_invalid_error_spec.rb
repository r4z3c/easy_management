require 'spec_helper'
require 'easy_management/errors/handled_record_invalid_error'

describe EasyManagement::Errors::HandledRecordInvalidError do

  let(:error) { EasyManagement::Errors::HandledRecordInvalidError }

  it { expect(error.superclass).to eq StandardError }

end