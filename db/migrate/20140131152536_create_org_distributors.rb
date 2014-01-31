class CreateOrgDistributors < ActiveRecord::Migration
  def change
    create_table :org_distributors do |t|
      t.integer :org_id
      t.integer :distributor_id

      t.timestamps
    end
    add_index :org_distributors, :org_id
    add_index :org_distributors, :distributor_id
  end
end
