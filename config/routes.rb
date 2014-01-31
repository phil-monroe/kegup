Kegup::Application.routes.draw do
  ActiveAdmin.routes(self)
  # Authentication
  get 'auth/facebook'
  get 'auth/logout' => 'auth#logout'
  get 'auth/facebook/callback' => 'auth#facebook'

  resources :orgs

  resources :org_user_memberships

  namespace :api do
    resources :orgs do
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
