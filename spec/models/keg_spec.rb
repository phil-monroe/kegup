require 'spec_helper'

describe Keg do
  it { should belong_to(:org) }
  it { should belong_to(:beer) }
end
