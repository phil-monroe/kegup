require 'spec_helper'

describe Org do
  it { should have_many(:beers) }
  it { should have_many(:org_beer_selections) }

  it "should always have a name" do
    expect(build(:org, name: '')).to_not be_valid
    expect(build(:org, name: nil)).to_not be_valid
    expect(build(:org, name: "Identified")).to be_valid
  end

end
