Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      #Huy developer
      resources :authorizations, except: [:index, :new, :edit]
      resources :users, except: [:new, :edit]
      resources :tags, except: [:new, :edit]
      resources :categories, except: [:new, :edit]
      resources :notifications, only: [:show]
      resources :likes, only: [:show]
      resources :follows, only: [:show]
      resources :follow_users, only: [:index, :show]
      namespace :articles do
        resources :hot_articles, only: [:index]
      end

      #Thap developer
      # resources :users
      resources :articles,only: [:index, :create, :update, :show, :destroy] do
        resources :comments,only: [:index,:create,:show,:update,:destroy]
      end
      resources :tags
    end
  end
end