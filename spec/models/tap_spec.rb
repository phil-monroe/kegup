require 'spec_helper'

describe Tap do

  it { should belong_to(:keg) }
  it { should belong_to(:org) }


  it 'must have a unique name for an org' do
    tap1 = build(:tap, org_id: 1, name: 'tap 1')
    expect(tap1).to be_valid
    tap1.save
    expect(build(:tap, org_id: 1, name: 'tap 1')).to_not be_valid
  end
end
