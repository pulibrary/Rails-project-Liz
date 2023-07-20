Rails.application.routes.draw do
  root "users#index"

  get "/create_account", to: "users#create_account"
  get "/scoreboard", to: "users#scoreboard", as: "scoreboard"

  get "/authenticate", to: "users#authenticate"
  post "/access_profile", to: "users#access_profile"

  # resource :user, only: [:edit, :update]
  

  post "/create_account", to: "users#create"

  # get "/users", to: "users#index"
  # get "/users/:id", to: "users#show"
  
  # This creates comments as a nested resource within articles. 
  #This is another part of capturing the hierarchical relationship that exists between articles and comments.
  resources :users do
    resources :scores
  end

end
