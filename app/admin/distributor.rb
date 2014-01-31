ActiveAdmin.register Distributor do
  controller do
    def permitted_params
      params.permit!
    end
  end

  index do
    column :id
    column :name
    column :phone
    column :contact_email
    column(:beer_count) { |d| d.beers.count }
    actions
  end

  show do
    columns do
      column do
        panel  "Details" do
          attributes_table_for distributor do
            row :name
            row :phone
            row :contact_email
            row :order_email
            row :address
            row :address_2
            row :city
            row :state
            row :zip
          end
        end
      end



      column do
        panel "Beers" do
          table_for distributor.beers do
            column(:id)
            column(:name)
            column(:style)
            column(:abv) { |beer| "#{beer.abv}%"}
          end
        end
      end
    end
  end


  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.actions

    f.inputs "Details" do
      f.input :name
      f.input :phone
      f.input :contact_email
      f.input :order_email
      f.input :address
      f.input :address_2
      f.input :city
      f.input :state
      f.input :zip
    end

    f.inputs "Available Beers" do
      f.has_many :distributor_beer_selections, allow_destroy: true do |bf|
        bf.input :beer
      end
    end

    f.actions

  end
end
