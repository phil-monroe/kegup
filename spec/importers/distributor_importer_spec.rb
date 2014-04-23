require 'spec_helper'

describe DistributorImporter do
  let(:file_path) { "spec/data/distributors.json" }
  let(:file_data) { File.read file_path }

  it 'loads from file' do
    importer = DistributorImporter.from_file(file_path)
    expect(importer.data.size).to be(3)
  end

  it 'loads from json data' do
    importer = DistributorImporter.new(file_data)
    expect(importer.data.size).to be(3)
  end

  describe '#import' do
    let(:importer){ DistributorImporter.from_file(file_path) }

    it 'imports new distributors' do
      expect{importer.import}.to change{ Distributor.count}.from(0).to(3)

      Distributor.all.each do |dist|
        expect(dist.name).to be_present
        expect(dist.phone).to be_present
        expect(dist.address).to be_present
        expect(dist.city).to be_present
        expect(dist.state).to be_present
        expect(dist.zip).to be_present

        expect(dist.beers).to be_present
      end
    end

    it 'updates old distributors' do
      test_dist = Distributor.create name: 'Test Distributor'

      expect{importer.import}.to change{ ::Distributor.count}.from(1).to(3)
      test_dist.reload

      expect(test_dist.city).to be_present
      expect(test_dist.beers).to be_present



    end
  end

end
