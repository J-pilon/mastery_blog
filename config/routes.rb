Rails.application.routes.draw do
  root "articles#index"
  
  get '/signup', to: 'registrations#new'
  post '/signup', to: 'registrations#create'
  get '/signin', to: 'sessions#new'
  post '/sessions', to: 'sessions#create'
  post '/signout', to: 'sessions#destroy'

  get 'uploads/storage_service'

  resources :articles
end
