require 'spec_helper'

describe Distributor do
  it { should have_many(:org_distributors) }
  it { should have_many(:orgs).through(:org_distributors) }
  it { should have_many(:distributor_beer_selections) }
  it { should have_many(:beers).through(:distributor_beer_selections) }
end
