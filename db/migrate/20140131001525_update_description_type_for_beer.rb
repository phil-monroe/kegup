class UpdateDescriptionTypeForBeer < ActiveRecord::Migration
  def change
    change_column :beers, :description, :text
  end
end
