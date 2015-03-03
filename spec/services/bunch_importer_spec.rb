require 'rails_helper'
include ActionDispatch::TestProcess
describe BunchImporter do
  let!(:pharmacy)  { create :pharmacy }
  let!(:bunch_key) { Random.rand }
  let!(:file)      { File.join self.class.fixture_path, 'price.csv' } 
  let!(:content)   { StringIO.new File.read file }

  let!(:max) { 1 }

  it { expect(pharmacy.drugs.count).to eq 0 }

  subject { described_class.
            new( pharmacy: pharmacy, 
                bunch_key: bunch_key, 
                max: max, 
                current: current ).
                catch_file content }

  context do
    let(:current) { 1 }
    specify do
      expect(subject).to be_a BunchFile
      expect(subject).to be_persisted
      expect(subject.file.file).to be_exists
      expect(subject.file.file.read.length).to eq content.length
      expect(pharmacy.drugs.count).to eq 2971
    end
  end

end
