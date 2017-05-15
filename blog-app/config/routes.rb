Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      #Huy developer
      post '/signup', to: 'users#create'
      post '/signin', to: 'authorizations#create'
      delete '/signout', to: 'authorizations#destroy'
      resources :users, only: [:index, :create] do
        member do
          get :confirm_email
        end
      end
      resources :tags
      resources :categories

      #Thap developer
      resources :users
      resources :articles

    end
  end
end