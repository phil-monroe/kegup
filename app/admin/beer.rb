ActiveAdmin.register Beer do
  permit_params :name, :description, :abv, :style, :brewed_by, :remote_image_url

  index do
    column 'Image' do |beer|
      image_tag beer.image_url(:thumb).to_s
    end
    column :name
    column :style
    column :abv
    actions
  end


  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs "Details" do
      f.input :name
      f.input :brewed_by
      f.input :style
      f.input :abv
      f.input :origin
      f.input :remote_image_url
      f.input :description
    end

    f.actions
  end


end
