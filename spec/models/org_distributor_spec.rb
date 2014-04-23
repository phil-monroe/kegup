require 'spec_helper'

describe OrgDistributor do
  it { should belong_to(:org).touch(true) }
  it { should belong_to(:distributor) }
end
