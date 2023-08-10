Rails.application.routes.draw do
  # get 'calendar/index'
  # post 'calendar/index'
  get 'calendar/:year/:month', to: 'calendar#index'
  get 'calendar/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tasks#index'
  resources :tasks, controller: :tasks do
    patch 'mark_as_completed', on: :member
  end

  get '/calendar', to: 'calendar#index'

  # get :tasks, controller: :tasks
  get :index_search, controller: :tasks
  # do
  #   get index_search, on: :collection
  #   member do

  #   end
  # end
  resources :recurring_tasks, controller: :tasks
end
