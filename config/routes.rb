Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tasks#index'
  resources :tasks
  get :index_search
  # do
  #   get index_search, on: :collection
  #   member do

  #   end
  # end
  resources :recurring_tasks, controller: :to_do_lists
end
