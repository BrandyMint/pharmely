require 'rails_helper'
include ActionDispatch::TestProcess
describe ImportService do
  let!(:pharmacy) { create :pharmacy }

  context '.zip.csv' do
    let!(:file)     { fixture_file_upload 'pricelist.csv.zip' }

    subject { described_class.new(pharmacy: pharmacy, file: file).perform }

    it do
      expect( subject ).to have(198).items
    end
  end

  context 'csv' do
    let!(:file)     { fixture_file_upload 'pricelist.csv' }

    subject { described_class.new(pharmacy: pharmacy, file: file).perform }

    it do
      expect( subject ).to have(198).items
    end
  end

  #context 'xls' do
    #let!(:file)     { fixture_file_upload 'pricelist.xls' }

    #subject { described_class.new(pharmacy: pharmacy, file: file).perform }

    #it do
      #expect( subject ).to have(37658).items
    #end
  #end

  context 'xlsx' do
    let!(:file)     { fixture_file_upload 'pricelist.xlsx' }

    subject { described_class.new(pharmacy: pharmacy, file: file).perform }

    it do
      expect( subject ).to have(43).items
    end
  end
end
