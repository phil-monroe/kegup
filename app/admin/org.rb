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

    panel "Taps" do
      table_for org.taps do
        column(:id)
        column(:name)
        column(:keg) { |tap| link_to(tap.keg.beer.name, admin_keg_path(tap.keg) )  if tap.keg.present? }
      end
    end

    panel "Kegs" do
      table_for org.kegs do
        column(:id)
        column(:beer)
        column(:on_tap) { |keg| keg.current_tap.present?.to_s  }
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

    f.inputs "Taps" do
      f.has_many :taps, allow_destroy: true do |bf|
        bf.input :name
        bf.input :keg
      end
    end

    f.inputs "Kegs" do
      f.has_many :kegs, allow_destroy: true do |bf|
        bf.input :beer
        bf.input :tapped_date
        bf.input :finished_date
      end
    end



    f.actions
  end
end
