require 'spec_helper'

describe OrgUserMembership do
  it { should belong_to(:user) }
  it { should belong_to(:org).touch(true) }
end
