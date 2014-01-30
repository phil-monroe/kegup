Kegup::Application.routes.draw do
  resources :beers

  resources :orgs

  root 'website#index'
end
