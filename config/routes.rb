Kegup::Application.routes.draw do
  resources :orgs

  root 'website#index'
end
