class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :fb_id
      t.string :fb_token
      t.integer :fb_token_expires,  limit: 8
      t.string :twitter_handle
      t.string :avatar_url
      t.string :fb_profile_url

      t.timestamps
    end

    add_index :users, :fb_id, unique: true
    add_index :users, :email, unique: true
  end
end
