Rails.application.routes.draw do
  root "users#index"
  get "/create_account", to: "users#create_account" # "as" here is used to alias path name
  get "/scoreboard", to: "users#scoreboard"
  get "/access_profile", to: "users#access_profile"
  get "/authenticate", to: "sessions#new"
  get "/list_players", to: "users#list_players"
  
  get "validate_username", to: "scores#validate_username"
  get "setup_game", to: "scores#setup_game"
  get "access_game", to: "scores#access_game"
  get "show_game", to: "scores#show_game"

  post "/create_session", to: "sessions#create"
  post "/create_account", to: "users#create"
  patch "/update", to: "scores#update"
  post "/access_game", to: "scores#access_game"
  # note: update (users) is done automatically upon using edit
 
  
  # This is another part of capturing the hierarchical relationship 
  # that exists between articles and comments:
  resources :users do
    resources :scores
  end

end
