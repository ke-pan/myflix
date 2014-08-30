Myflix::Application.routes.draw do
  root to: "pages#front"

  get '/home', to: 'videos#index'
  get '/ui(/:action)', controller: 'ui'

  resources :videos, only: [:index, :show] do
    get 'search', on: :collection
    post 'add_to_queue', on: :member
    resources :reviews, only: [:create]
  end
  namespace :admin do
    resources :videos, only: [:new, :create]
    resources :payments, only: [:index]
  end
  resources :categories, only: [:show]

  get '/register/(:token)', to: 'users#new', as: "register"
  resources :users, only: [:create, :show] do
    get 'plan_and_billing', to: 'billings#index'
  end
  mount StripeEvent::Engine => '/stripe-webhooks'

  get 'forget_password', to: 'reset_password#forget_password'
  post 'send_reset_password_email', to: 'reset_password#send_reset_password_email'
  get 'invalid_token', to: 'reset_password#invalid_token'
  get 'new_password/:token', to: 'reset_password#new_password', as: :new_password
  post 'update_password', to: 'reset_password#update_password'


  get '/people', to: 'followships#index'
  resources :followships, only: [:create, :destroy]

  get '/my_queue', to: 'queue_items#index'
  resources :queue_items, only: [:destroy]
  put 'update_queue_items', to: 'queue_items#update'

  get '/invite', to: 'invitations#new'
  resources :invitations, only: [:create]
  get '/invitation_confirm', to: 'invitations#confirm'

  get '/signin',  to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'

end
