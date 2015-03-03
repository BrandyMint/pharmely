require 'rails_helper'
include ActionDispatch::TestProcess
describe ImportService do
  let!(:pharmacy) { create :pharmacy }
  let!(:drug) { create :drug, pharmacy: pharmacy }


  it do
    expect(pharmacy.drugs.count).to eq 1
  end
  #before :all do
    #DrugsIndex.purge
  #end

  #context '.zip.csv' do
    #let!(:file)     { fixture_file_upload 'pricelist.csv.zip' }

    #subject { described_class.new(pharmacy: pharmacy, files: [file]).perform }

    #it do
      #expect( subject ).to eq [198,0]
    #end
  #end

  context 'csv' do
    let!(:file)     { fixture_file_upload 'price.csv' }
    let(:drugs_count) { 2971 }

    before do
      drug
    end

    subject { described_class.new(pharmacy: pharmacy, files: [file]).perform }

    specify do
      expect( subject ).to eq [drugs_count,0]
      expect(pharmacy.drugs.count).to eq drugs_count
    end

  end

  #context 'xls' do
    #let!(:file)     { fixture_file_upload 'pricelist.xls' }

    #subject { described_class.new(pharmacy: pharmacy, file: file).perform }

    #it do
      #expect( subject ).to eq [37658, 0]
    #end
  #end

  context 'xlsx' do
    let!(:file)     { fixture_file_upload 'pricelist.xlsx' }

    subject { described_class.new(pharmacy: pharmacy, files: [file]).perform }

    it do
      expect( subject ).to eq [43, 0]
    end
  end
end
