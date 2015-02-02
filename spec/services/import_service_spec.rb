require 'rails_helper'
include ActionDispatch::TestProcess
describe ImportService do
  let(:pharmacy) { create :pharmacy }

  let(:file)     { fixture_file_upload 'pricelist.xlsx' }

  subject { described_class.new(pharmacy: pharmacy, file: file).perform }

  it do
    expect( subject ).to have(43).items
  end
end

