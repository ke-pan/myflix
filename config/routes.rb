Myflix::Application.routes.draw do
  root "users#front"
  get '/home', to: 'videos#index'
  get 'ui(/:action)', controller: 'ui'
  get 'videos/search', to: 'videos#search'

  resources :videos, only: [:index, :show]
  resources :categories, only: [:show]

  get 'register', to: 'users#new'
  resources :users, only: [:create]

  get 'signin',  to: 'session#new'
  post '/signin', to: 'session#create'
  get 'signout', to: 'session#destroy'

end
