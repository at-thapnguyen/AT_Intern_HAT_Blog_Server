Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      #Huy developer
      resources :authorizations, except: [:index, :new, :edit]
      resources :users, param: :username, except: [:new, :edit] do
        member do
          get "/user_articles", to: "users/user_articles#index"
        end
        resources :follow_users, only: [:index, :create]
        resources :notification_users, only: [:index]
        resources :notifications, only: [:index,:update]
      end
      namespace :articles do
        resources :hot_articles, only: [:index]
      end
      resources :tags, except: [:new, :edit]
      resources :categories, except: [:new, :edit]
      namespace :articles do
        resources :hot_articles, only: [:index]
      end
      resources :searchs, param: :key, only: [:show]

      #Thap developer
      resources :articles, param: :slug,only: [:index,:create, :update, :show, :destroy] do
        resources :comments
        resources :likes, only: [:index, :create]
        resources :follows, only: [:index,:create]
      end
      resources :tags
    end
  end
end