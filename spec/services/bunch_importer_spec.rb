require 'rails_helper'
include ActionDispatch::TestProcess
describe BunchImporter do
  let!(:pharmacy)  { create :pharmacy }
  let!(:bunch_key) { Random.rand }
  let!(:file)      { File.join self.class.fixture_path, 'price.csv' } 
  let!(:content)   { File.read file }

  let!(:max) { 3 }

  subject { described_class.
            new( pharmacy: pharmacy, 
                bunch_key: bunch_key, 
                max: max, 
                current: current ).catch_file content }

  context do
    let(:current) { 1 }
    specify do
      expect(subject).to be_a BunchFile
      expect(subject).to be_persisted
      expect(subject.file.file).to be_exists
      expect(subject.file.file.read.length).to eq content.length
    end
  end

end
