Kegup::Application.routes.draw do
  ActiveAdmin.routes(self)
  resources :beers

  resources :orgs

  root 'website#index'
end
