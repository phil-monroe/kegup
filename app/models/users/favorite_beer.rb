class Users::FavoriteBeer < ActiveRecord::Base
  belongs_to :user
  belongs_to :beer

  validates :beer_id, uniqueness: { scope: :user_id, message: "has already been added" }

  validate :user_count, on: :create

   def user_count
     errors.add(:too_many, "favorite beers for #{self.user.name} (Max 3)") if self.class.where(user_id: self.user_id).count >= 3
   end
end
