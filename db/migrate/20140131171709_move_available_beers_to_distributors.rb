class MoveAvailableBeersToDistributors < ActiveRecord::Migration
  def change
    rename_table :org_beer_selections, :distributor_beer_selections
    rename_column :distributor_beer_selections, :org_id, :distributor_id

  end
end
