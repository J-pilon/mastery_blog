Rails.application.routes.draw do
  root "articles#index"
  
  get '/signup', to: 'registrations#new'
  post '/signup', to: 'registrations#create'
  get '/signin', to: 'sessions#new'
  post '/sessions', to: 'sessions#create'
  post '/signout', to: 'sessions#destroy'
  
  get 'uploads/storage_service'

  resource :profile, only: [:show, :edit, :update], controller: 'profile'

  resource :user, only: [:edit, :update], controller: 'user'
  
  resources :articles
end
