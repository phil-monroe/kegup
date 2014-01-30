ActiveAdmin.register Org do
  controller do
    def permitted_params
      params.permit!
    end
  end

  show do
    attributes_table do
      row :id
      row :name
    end


    panel "Beers" do
      table_for org.beers do
        column(:id)
        column(:name)
        column(:style)
        column(:abv) { |beer| "#{beer.abv}%"}
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs "Details" do
      f.input :name
    end

    f.inputs "Available Beers" do
      f.has_many :org_beer_selections, allow_destroy: true do |bf|
        bf.input :beer
      end
    end



    f.actions
  end
end
