require 'spec_helper'

describe OrgBeerSelection do
  it 'must be unique between org and beer' do
    selection1 = build(:org_beer_selection)
    expect(selection1).to be_valid
    selection1.save
    expect(build(:org_beer_selection)).to_not be_valid
  end
end
