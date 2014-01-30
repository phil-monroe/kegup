class CreateTaps < ActiveRecord::Migration
  def change
    create_table :taps do |t|
      t.integer :org_id
      t.string :name
      t.integer :keg_id

      t.timestamps
    end
    add_index :taps, :org_id
    add_index :taps, :keg_id
  end
end
