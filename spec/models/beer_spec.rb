require 'spec_helper'

describe Beer do
  it { should have_many(:orgs) }
  it { should have_many(:org_beer_selections) }

  it 'validates name' do
    expect(build(:beer)).to be_valid
    expect(build(:beer, name: '')).to_not be_valid
  end

  it 'validates styles' do
    expect(build(:beer, style: 'IPA')).to be_valid
    expect(build(:beer, style: 'FOO')).to_not be_valid
  end





end
