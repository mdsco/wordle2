Rails.application.routes.draw do
  resources :games
  post '/letter_update', to: "games#letter_update" 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "games#index"
end
