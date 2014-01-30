class CreateKegs < ActiveRecord::Migration
  def change
    create_table :kegs do |t|
      t.integer :beer_id
      t.integer :org_id
      t.datetime :tapped_date
      t.datetime :finished_date

      t.timestamps
    end
    add_index :kegs, :beer_id
    add_index :kegs, :org_id
  end
end
