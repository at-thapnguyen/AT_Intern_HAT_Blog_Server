Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      #Huy developer
      resources :authorizations, except: [:index, :new, :edit]
      resources :users, param: :username, except: [:new, :edit] do
        resources :follow_users, only: [:index, :show]
      end
      resources :tags, except: [:new, :edit]
      resources :categories, except: [:new, :edit]
      resources :notifications, only: [:show]

      #Thap developer
      resources :articles,only: [:index, :create, :update, :show, :destroy] do
        resources :comments,only: [:index,:create,:show,:update,:destroy]
        resources :hot_articles, only: [:index]
        resources :likes, only: [:index]
        resources :follows, only: [:index]
      end
      resources :tags
    end
  end
end