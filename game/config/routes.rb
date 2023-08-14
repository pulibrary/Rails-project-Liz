Rails.application.routes.draw do
  root "users#index"
  get "/create_account", to: "users#create_account" # "as" here is used to alias path name
  get "/scoreboard", to: "users#scoreboard"
  get "/access_profile", to: "users#access_profile"
  get "/authenticate", to: "sessions#new"
  get "/list_players", to: "users#list_players"
  get "/connect4", to: "scores#access_game"
  get "validate_username", to: "scores#validate_username"
  get "/new_game", to: "scores#start_new_game"

  post "/create_session", to: "sessions#create"
  post "/create_account", to: "users#create"
 
  
  # This is another part of capturing the hierarchical relationship 
  # that exists between articles and comments:
  resources :users do
    resources :scores
  end

end
