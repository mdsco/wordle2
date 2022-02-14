Rails.application.routes.draw do

  resources :games
  # post '/update/:id', to: 'games#update'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "games#index"
end
