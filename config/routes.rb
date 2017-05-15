Rails.application.routes.draw do

  root to: "toppages#index"
  
  resources :tasks
  
  get "done", to:"tasks#done"
  get "signup", to: "users#new"
  resources :users, only: [:index, :show, :new, :create]
 
end