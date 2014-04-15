class User < ActiveRecord::Base
  # Associations =======================================================================================================
  has_many :org_user_memberships
  has_many :orgs, through: :org_user_memberships

  has_many :favorite_beers, class_name: Users::FavoriteBeer
  has_many :beers, through: :favorite_beers

  # Validations ========================================================================================================
  validates :email, uniqueness: true, format: /\A.+@.+\..+\z/i, allow_blank: true

  # Class Methods ======================================================================================================
  def self.from_facebook auth_hash
    find_or_create_by!(fb_id: auth_hash[:uid]) do |user|
      user.first_name        = auth_hash[:info][:first_name]
      user.last_name         = auth_hash[:info][:last_name]
      user.email             = auth_hash[:info][:email]
      user.fb_token          = auth_hash[:credentials][:token]
      user.fb_token_expires  = auth_hash[:credentials][:expires_at]
      user.avatar_url        = auth_hash[:info][:image]
      user.fb_profile_url    = auth_hash[:info][:urls][:Facebook]
    end
  end


  # Callbacks ==========================================================================================================


  # Instance Methods ===================================================================================================
  def name
    "#{first_name} #{last_name}"
  end

  def kegmeister_for org
    kegmeister_orgs.include? org
  end

  def member_for org
    orgs.include? org
  end

  def kegmeister_orgs
    @kegmeister_orgs ||= self.orgs.merge(OrgUserMembership.kegmeisters)
  end

  def beers_with_favorite_id
    beers.select('beers.*, users_favorite_beers.id as favorite_beer_id')
  end

  def high_res_avatar_url(width=20,height=20)
    "http://graph.facebook.com/#{self.fb_id}/picture?width=#{width}&height=#{height}"
  end
end
