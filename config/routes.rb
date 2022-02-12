Rails.application.routes.draw do
  # get 'games/index'
  # get 'games/show'

  resources :games
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "games#index"
end
