class CreateOrgBeerSelections < ActiveRecord::Migration
  def change
    create_table :org_beer_selections do |t|
      t.integer :org_id
      t.integer :beer_id

      t.timestamps
    end

    add_index :org_beer_selections, :beer_id
    add_index :org_beer_selections, :org_id
  end
end
