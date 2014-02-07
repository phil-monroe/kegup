require 'spec_helper'

describe DistributorBeerSelection do
  it 'must be unique between distributor and beer' do
    selection1 = build(:distributor_beer_selection)
    expect(selection1).to be_valid
    selection1.save
    expect(build(:distributor_beer_selection)).to_not be_valid
  end
end
