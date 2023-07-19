Rails.application.routes.draw do
  root "users#index"

  # get "/users", to: "users#index"
  # get "/users/:id", to: "users#show"
  
  resources :users
 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
