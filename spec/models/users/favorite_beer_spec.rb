require 'spec_helper'

describe Users::FavoriteBeer do
  it { should belong_to(:user) }
  it { should belong_to(:beer) }

  it 'must have no more than three' do
    user = create(:user, favorite_beer_count: 3)
    favorite_beer = build(:favorite_beer, user: user)
    expect(favorite_beer).to_not be_valid
    expect(favorite_beer).to have(1).errors_on(:too_many)
  end
end
