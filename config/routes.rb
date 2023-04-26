Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tasks#index'
  resources :tasks
  # do
  #   get index_search, on: :collection
  #   member do

  #   end
  # end
end
