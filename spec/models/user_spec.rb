require 'spec_helper'

describe User do
  it 'can parse a facebook hash' do
    auth_hash = Hashie::Mash.new({"provider"=>"facebook",
     "uid"=>"1421370003",
     "info"=>
      {"nickname"=>"phil.monroe",
       "email"=>"phil@philmonroe.com",
       "name"=>"Phil Monroe",
       "first_name"=>"Phil",
       "last_name"=>"Monroe",
       "image"=>"http://graph.facebook.com/1421370003/picture",
       "urls"=>{"Facebook"=>"https://www.facebook.com/phil.monroe"},
       "verified"=>true},
     "credentials"=>
      {"token"=>
        "CAALnr7YqEVkBAAOSF78P5sA0vZCCdlOtpsxpIOQsptm5YycIUjPdgLp55csMzIXyqV587bJEnHnnaSv6ZAyW4TwLPcEOuJJ4a5DUi2XZCNKMDGRR8HGhuOeaVg1t3P1l6ZA80NPSlh4GayUAhOVj5Ne4B0PVluUBhG70qjGVFpAvlZBwCaWfUkZAEtxzbmnk8ZD",
       "expires_at"=>1396318972,
       "expires"=>true},
     "extra"=>
      {"raw_info"=>
        {"id"=>"1421370003",
         "name"=>"Phil Monroe",
         "first_name"=>"Phil",
         "last_name"=>"Monroe",
         "link"=>"https://www.facebook.com/phil.monroe",
         "gender"=>"male",
         "email"=>"phil@philmonroe.com",
         "timezone"=>-8,
         "locale"=>"en_US",
         "verified"=>true,
         "updated_time"=>"2013-11-19T23:21:50+0000",
         "username"=>"phil.monroe"}}})
    user = User.from_facebook auth_hash
    expect(user).to be_persisted
    expect(user.first_name).to eq("Phil")
    expect(user.last_name).to eq("Monroe")
    expect(user.email).to eq("phil@philmonroe.com")
    expect(user.fb_token).to be_present
  end
end
