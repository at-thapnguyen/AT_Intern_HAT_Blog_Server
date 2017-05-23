Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      #Huy developer
      post '/signup', to: 'users#create'
      post '/signin', to: 'authorizations#create'
      delete '/signout', to: 'authorizations#destroy'
      put '/reset_password', to: 'authorizations#update'
      # resources :attentions, only: [:index]
      get '/likes', to: 'likes#show'
      get '/follows', to: 'follows#show'
      get '/followers', to: 'followers#show'

      post '/suggests', to: 'suggests#create'
      resources :users, only: [:index, :create, :update, :show, :destroy] do
        member do
          get :confirm_email
        end
      end
      resources :tags, only: [:index, :create, :update, :show, :destroy]
      resources :categories, only: [:index, :create, :update, :show, :destroy]

      #Thap developer
      # resources :users
      resources :articles,only: [:index, :create, :update, :show, :destroy] do
        resources :comments,only: [:index,:create,:show,:update,:destroy]
      end
    end
  end
end