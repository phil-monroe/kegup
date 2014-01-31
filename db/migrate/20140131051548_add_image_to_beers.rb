class AddImageToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :image, :string
  end
end
