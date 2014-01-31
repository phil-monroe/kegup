Kegup::Application.routes.draw do
  resources :distributors

  ActiveAdmin.routes(self)
  # Authentication
  get 'auth/facebook'
  get 'auth/logout' => 'auth#logout'
  get 'auth/facebook/callback' => 'auth#facebook'

  resources :orgs do
    resources :kegs
  end

  resources :org_user_memberships

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
