Kegup::Application.routes.draw do
  ActiveAdmin.routes(self)

  resources :orgs

  root 'website#index'
end
