Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      post '/authenticate', to: 'authentication#authenticate'
      resources :farms
    end
  end
  
end
