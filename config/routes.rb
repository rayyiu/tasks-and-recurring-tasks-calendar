Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tasks#index'
  resources :tasks, controller: :tasks
  # get :tasks, controller: :tasks
  get :index_search, controller: :tasks
  # do
  #   get index_search, on: :collection
  #   member do

  #   end
  # end
  resources :recurring_tasks, controller: :tasks
end
