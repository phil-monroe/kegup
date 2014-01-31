ActiveAdmin.register Distributor do
  permit_params :name, :phone, :contact_email, :order_email, :address, :address_2, :city, :state, :zip
end
