Rails.application.routes.draw do
  root "users#index"
  get "/create_account", to: "users#create_account"
  get "/scoreboard", to: "users#scoreboard"
  get "/access_profile", to: "users#access_profile"
  get "/authenticate", to: "sessions#new"
  get "/list_players", to: "users#list_players"
  # get "/edit", to: "users#edit"

  post "/create_session", to: "sessions#create"
  post "/create_account", to: "users#create"
  post "/edit", to: "users#edit"

   
  # This is another part of capturing the hierarchical relationship 
  # that exists between articles and comments:

  resources :users do
    resources :scores
  end

end
