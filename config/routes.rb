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
  resources :users, only: [:create, :show]

  get '/people', to: 'followships#index'
  resources :followships, only: [:create, :destroy]

  get '/my_queue', to: 'queue_items#index'
  resources :queue_items, only: [:destroy]
  put 'update_queue_items', to: 'queue_items#update'


  get '/signin',  to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'

end
