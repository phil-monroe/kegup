class User < ActiveRecord::Base
  # Associations =======================================================================================================
  has_many :org_user_memberships
  has_many :orgs, through: :org_user_memberships

  # Validations ========================================================================================================
  validates :email, uniqueness: true, format: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/

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

  def kegmaster_for org
    kegmaster_orgs.include? org
  end

  def kegmaster_orgs
    @kegmaster_orgs ||= self.orgs.merge(OrgUserMembership.kegmasters)
  end
end
