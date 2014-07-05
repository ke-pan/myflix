Myflix::Application.routes.draw do
  root to: "pages#front"
  get '/home', to: 'videos#index'
  get '/ui(/:action)', controller: 'ui'

  resources :videos, only: [:index, :show] do
    get 'search', on: :collection
  end
  resources :categories, only: [:show]

  get '/register', to: 'users#new'
  resources :users, only: [:create]

  get '/signin',  to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'

end
