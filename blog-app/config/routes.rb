# Rails.application.routes.draw do

#   resources :users

# end

Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users
      resources :articles
    end
  end  
end