class AddOriginToBeer < ActiveRecord::Migration
  def change
    add_column :beers, :origin, :string
  end
end
