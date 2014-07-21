Myflix::Application.routes.draw do
  root to: "pages#front"
  get '/home', to: 'videos#index'
  get '/ui(/:action)', controller: 'ui'

  resources :videos, only: [:index, :show] do
    get 'search', on: :collection
    post 'add_to_queue', on: :member
    resources :reviews, only: [:create]
  end
  resources :categories, only: [:show]

  get '/register', to: 'users#new'
  resources :users, only: [:create]

  get '/my_queue', to: 'queue_items#index'
  resources :queue_items, only: [:destroy]
  put 'update_queue_items', to: 'queue_items#update'
  # delete '/remove_queue_items/:id', to: 'queue_items#remove_queue_item', as: 'remove_queue_item'
  # resources :queue_items, only: [:show, :create]


  get '/signin',  to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'

end
