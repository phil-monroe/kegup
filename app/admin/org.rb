ActiveAdmin.register Org do
  controller do
    def permitted_params
      params.permit!
    end
  end

  show do
    columns do
      column do
        panel  "Details" do
          attributes_table_for org do
            row :id
            row :name
            row :reminder_email
          end
        end

        panel "Taps" do
          table_for org.taps do
            column(:id)
            column(:name)
            column(:keg)  { |tap| link_to(tap.keg.short_name, admin_keg_path(tap.keg) )       if tap.keg.present? }
            column(:beer) { |tap| link_to(tap.keg.beer.name, admin_beer_path(tap.keg.beer) )  if tap.keg.present? }
            column(:tapped_date) { |tap| format_date(tap.keg.tapped_date)  if tap.keg.present? }
          end
        end

        panel "Members" do
          table_for org.users do
            column(:id)
            column(:name)
            column(:kegmeister) { |user| org.kegmeisters.include?(user) }
          end
        end
      end



      column do
        panel "Distributors" do
          table_for org.distributors do
            column :id
            column :name
            column :phone
            column :order_email
          end
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
    end

    panel "Kegs" do
      table_for org.kegs.order("id DESC").limit(25) do
        column(:id)
        column(:short_name) { |keg| link_to(keg.short_name, admin_keg_path(keg)) if keg.present?  }
        column(:beer)
        column(:on_tap) { |keg| keg.current_tap.present?.to_s  }
        column(:tapped_date){ |keg| format_date(keg.tapped_date) }
        column(:finished_date){ |keg| format_date(keg.tapped_date) }
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs "Details" do
      f.input :name
      f.input :reminder_email
    end

    f.inputs "Distributors" do
      f.has_many :org_distributors, allow_destroy: true do |bf|
        bf.input :distributor
      end
    end

    f.inputs "Taps" do
      f.has_many :taps, allow_destroy: true do |bf|
        bf.input :name
        bf.input :keg, collection: [bf.object.keg, f.object.kegs.backlogged].flatten.compact
      end
    end

    f.inputs "Members" do
      f.has_many :org_user_memberships, allow_destroy: true do |bf|
        bf.input :user, input_html: { :disabled => true }
        bf.input(:is_kegmeister, label: 'Kegmeister')
      end
    end

    f.inputs "Kegs" do
      f.has_many :kegs, allow_destroy: true do |bf|
        bf.input :id, as: :string, input_html: { :disabled => true }
        bf.input :beer
        bf.input :tapped_date
        bf.input :finished_date
      end
    end

    f.actions
  end
end
