Rails.application.routes.draw do
  root "articles#index"
  
  resources :registrations, only: :create
  get '/signup', to: 'registrations#new'
  get '/signin', to: 'sessions#new'
  post '/sessions', to: 'sessions#create'
  post '/signout', to: 'sessions#destroy'

  get 'uploads/presigned_url'

  resources :articles
end
