require 'spec_helper'

describe User  do
  it 'can parse a facebook hash' do
    user = User.from_facebook phil_hash
    expect(user).to be_persisted
    expect(user.first_name).to eq("Phil")
    expect(user.last_name).to eq("Monroe")
    expect(user.email).to eq("phil@philmonroe.com")
    expect(user.fb_token).to be_present
  end

  it 'can import tejas' do
    user = User.from_facebook tejas_hash
    expect(user).to be_present
    expect(user).to be_valid
    expect(user).to be_persisted
  end

  it 'can have an empty email' do
    expect(build(:user, email: nil)).to be_valid
    expect(build(:user, email: "")).to be_valid
  end

  it 'has to match a valid email address if present' do
    expect(build(:user)).to be_valid
    expect(build(:user, email: "foo@email.com")).to be_valid
    expect(build(:user, email: "foo")).to_not be_valid
  end

  let(:phil_hash) { YAML.load(PHIL) }
  let(:tejas_hash) { YAML.load(TEJAS) }

  TEJAS = <<-AUTH_HASH
--- !ruby/hash:OmniAuth::AuthHash
provider: facebook
uid: '1645980224'
info: !ruby/hash:OmniAuth::AuthHash::InfoHash
  nickname: tejas.mandke
  name: Tejas Ravindra Mandke
  first_name: Tejas
  last_name: Mandke
  image: http://graph.facebook.com/1645980224/picture
  urls: !ruby/hash:OmniAuth::AuthHash
    Facebook: https://www.facebook.com/tejas.mandke
  location: San Francisco, California
  verified: true
credentials: !ruby/hash:OmniAuth::AuthHash
  token: CAAHBZCpylIBgBADTkxMDN4bOXAo6TKAWVIS0W0ZA4vuPRl1g3z8qXfNs3BcwlOzsw9odFtLUgv56fcJe1V55WnPAJozgTZAT2ZBsp2uH6eHZChOTB4uQJxMEL1xw1tvPOkxsbu6Ky7d6Sy57g8rYiZB4bgCEXJtZCMqty0zWC2ZAAnFXbrkbpwpu
  expires_at: 1397076265
  expires: true
extra: !ruby/hash:OmniAuth::AuthHash
  raw_info: !ruby/hash:OmniAuth::AuthHash
    id: '1645980224'
    name: Tejas Ravindra Mandke
    first_name: Tejas
    middle_name: Ravindra
    last_name: Mandke
    link: https://www.facebook.com/tejas.mandke
    location: !ruby/hash:OmniAuth::AuthHash
      id: '114952118516947'
      name: San Francisco, California
    gender: male
    timezone: -8
    locale: en_US
    verified: true
    updated_time: '2013-12-16T00:35:31+0000'
    username: tejas.mandke
AUTH_HASH

  PHIL = <<-AUTH_HASH
--- !ruby/hash:OmniAuth::AuthHash
provider: facebook
uid: '1421370003'
info: !ruby/hash:OmniAuth::AuthHash::InfoHash
  nickname: phil.monroe
  email: phil@philmonroe.com
  name: Phil Monroe
  first_name: Phil
  last_name: Monroe
  image: http://graph.facebook.com/1421370003/picture
  urls: !ruby/hash:OmniAuth::AuthHash
    Facebook: https://www.facebook.com/phil.monroe
  location: San Francisco, California
  verified: true
credentials: !ruby/hash:OmniAuth::AuthHash
  token: CAALnr7YqEVkBAHmv9CPJDMrnlFTvaOjETbQiBqUDdpOvQJHBuPkOguZCKxb91fOoUhj6LiagfJEBZBY2Bbw0ubKcqWzJ5u5r1O4RWlcSqSlhIdUZBdvzrZBVQAqZBmhhRoxwRZCIO57MzZCLjfCJgAvlPJvdeDgbNJnBoBZAMY39eZBvwVkJVj9oq8MCVEOa7MeIZD
  expires_at: 1397075948
  expires: true
extra: !ruby/hash:OmniAuth::AuthHash
  raw_info: !ruby/hash:OmniAuth::AuthHash
    id: '1421370003'
    name: Phil Monroe
    first_name: Phil
    last_name: Monroe
    link: https://www.facebook.com/phil.monroe
    hometown: !ruby/hash:OmniAuth::AuthHash
      id: '104067269629245'
      name: Johnstown, Ohio
    location: !ruby/hash:OmniAuth::AuthHash
      id: '114952118516947'
      name: San Francisco, California
    quotes: "When you die, you lose a very important part of your life.\n\nIt's not
      quite to the end of the world, but you can see it from there.                                                \n\nwoot"
    work:
    - !ruby/hash:OmniAuth::AuthHash
      employer: !ruby/hash:OmniAuth::AuthHash
        id: '388271510992'
        name: Identified
      location: !ruby/hash:OmniAuth::AuthHash
        id: '114952118516947'
        name: San Francisco, California
      position: !ruby/hash:OmniAuth::AuthHash
        id: '113745088679001'
        name: Software Engineer/Team Lead
      description: Ruby on Rails backend development.
      start_date: '2012-03-01'
    - !ruby/hash:OmniAuth::AuthHash
      employer: !ruby/hash:OmniAuth::AuthHash
        id: '514552858585063'
        name: RBSavvy, LLC
      location: !ruby/hash:OmniAuth::AuthHash
        id: '112418268773756'
        name: Athens, Ohio
      position: !ruby/hash:OmniAuth::AuthHash
        id: '106324149403234'
        name: Co-founder
      description: A small Ruby on Rails shop.
      start_date: '2011-01-01'
    - !ruby/hash:OmniAuth::AuthHash
      employer: !ruby/hash:OmniAuth::AuthHash
        id: '329970143740617'
        name: Pacific Northwest National Lab
      location: !ruby/hash:OmniAuth::AuthHash
        id: '111920165491909'
        name: Richland, Washington
      position: !ruby/hash:OmniAuth::AuthHash
        id: '125784470808568'
        name: NVAC Intern
      description: I worked on various problems relating to Computer Vision.
      start_date: '2010-06-01'
      end_date: '2010-08-01'
    - !ruby/hash:OmniAuth::AuthHash
      employer: !ruby/hash:OmniAuth::AuthHash
        id: '113969435327543'
        name: Ohio University School of Music
      position: !ruby/hash:OmniAuth::AuthHash
        id: '144411972236001'
        name: Head Sound Engineer
      description: I record recitals and concerts for the school of music.
      start_date: '2007-11-01'
      end_date: '2011-08-01'
    - !ruby/hash:OmniAuth::AuthHash
      employer: !ruby/hash:OmniAuth::AuthHash
        id: '55208751357'
        name: Studimo Productions
      location: !ruby/hash:OmniAuth::AuthHash
        id: '104057022965169'
        name: Ashland, Kentucky
      position: !ruby/hash:OmniAuth::AuthHash
        id: '105330002880540'
        name: Intern/Sound + Light Engineer
      description: Setting up stages and helping with sound and lighting for concerts
        around Ohio, Kentucky, and West Virginia.
      start_date: '2007-05-01'
      end_date: '2011-08-01'
    sports:
    - !ruby/hash:OmniAuth::AuthHash
      id: '371047701649'
      name: Marching 110
      with:
      - !ruby/hash:OmniAuth::AuthHash
        id: '12305008'
        name: Amidy Bibbidy
      from: !ruby/hash:OmniAuth::AuthHash
        id: '12305008'
        name: Amidy Bibbidy
    education:
    - !ruby/hash:OmniAuth::AuthHash
      school: !ruby/hash:OmniAuth::AuthHash
        id: '115582188456304'
        name: Johnstown - Monroe
      year: !ruby/hash:OmniAuth::AuthHash
        id: '137616982934053'
        name: '2006'
      type: High School
    - !ruby/hash:OmniAuth::AuthHash
      school: !ruby/hash:OmniAuth::AuthHash
        id: '113667211977396'
        name: Ohio University
      year: !ruby/hash:OmniAuth::AuthHash
        id: '144044875610606'
        name: '2011'
      concentration:
      - !ruby/hash:OmniAuth::AuthHash
        id: '322049517824235'
        name: Audio & Music Production
      - !ruby/hash:OmniAuth::AuthHash
        id: '104076956295773'
        name: Computer Science
      type: College
    - !ruby/hash:OmniAuth::AuthHash
      school: !ruby/hash:OmniAuth::AuthHash
        id: '13917075214'
        name: UC Davis
      degree: !ruby/hash:OmniAuth::AuthHash
        id: '186098714763107'
        name: Electrical and Computer Engineering
      year: !ruby/hash:OmniAuth::AuthHash
        id: '293650690709608'
        name: '2012'
      type: Graduate School
    gender: male
    email: phil@philmonroe.com
    timezone: -8
    locale: en_US
    verified: true
    updated_time: '2013-11-19T23:21:50+0000'
    username: phil.monroe
AUTH_HASH
end
