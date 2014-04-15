Kegup::Application.routes.draw do
  resources :distributors

  ActiveAdmin.routes(self)
  # Authentication
  get 'auth/facebook'
  get 'auth/logout' => 'auth#logout'
  get 'auth/facebook/callback' => 'auth#facebook'

  resources :orgs do
    resources :org_user_memberships
    resources :kegs
  end

  resources :users, only: [:show, :edit, :update]
  resources :users_favorite_beers, path: 'my-beers'


  namespace :api do
    resources :orgs do
      member do
        get 'bother'
      end

      resources :taps do
        member do
          patch 'finished'
          patch 'tapped'
        end
      end
    end
  end

  root 'website#index'
end
