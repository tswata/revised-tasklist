Rails.application.routes.draw do

  root to: "toppages#index"
  
  resources :tasks
  
  get "done", to:"tasks#done"
  get "signup", to: "users#new"
  resources :users, only: [:index, :show, :new, :create]
 
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
end