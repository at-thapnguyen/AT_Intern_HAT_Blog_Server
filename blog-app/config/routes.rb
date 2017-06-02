Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      #Huy developer
      resources :authorizations, except: [:index, :new, :edit]
      resources :users, param: :username, except: [:new, :edit] do
        resources :follow_users, only: [:index, :show]
      end
      resources :tags, except: [:new, :edit]

      resources :notifications, only: [:show]
      #Thap developer
      resources :categories, except: [:new, :edit] do
        resources :articles, except: [:new, :edit] do
          resources :comments,only: [:index,:create,:show,:update,:destroy]
          resources :likes, only: [:create]
          resources :follows, only: [:create]
        end
        resources :hot_articles, only: [:index]
      end
      resources :tags
    end
  end
end