Rails.application.routes.draw do
  root "users#index"
  get "/create_account", to: "users#create_account"
  get "/scoreboard", to: "users#scoreboard"
  get "/access_profile", to: "users#access_profile"
  get "/authenticate", to: "sessions#new"
  get "/list_users", to: "users#list_users"

  post "/create_session", to: "sessions#create"
  post "/create_account", to: "users#create"

  # get "/users", to: "users#index"
  # get "/users/:id", to: "users#show"
  
  # This creates comments as a nested resource within articles. 
  #This is another part of capturing the hierarchical relationship that exists between articles and comments.
  resources :users do
    resources :scores
  end

end
