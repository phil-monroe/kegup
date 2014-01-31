class CreateOrgUserMemberships < ActiveRecord::Migration
  def change
    create_table :org_user_memberships do |t|
      t.integer :org_id
      t.integer :user_id
      t.boolean :is_kegmaster, default: false

      t.timestamps
    end
    add_index :org_user_memberships, :org_id
    add_index :org_user_memberships, :user_id
  end
end
