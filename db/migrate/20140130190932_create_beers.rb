class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |t|
      t.string :name
      t.string :brewed_by
      t.string :style
      t.string :description
      t.float :abv

      t.timestamps
    end
  end
end
