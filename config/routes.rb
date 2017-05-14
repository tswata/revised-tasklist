Rails.application.routes.draw do

  root to: "tasks#index"
  resources :tasks
  
  get "done", to:"tasks#done"
 
end