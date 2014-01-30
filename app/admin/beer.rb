ActiveAdmin.register Beer do
  permit_params :name, :description, :abv, :style, :brewed_by

end
