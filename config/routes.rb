Rails.application.routes.draw do
  root "articles#index"
  
  resources :registrations, only: :create
  get '/signup', to: 'registrations#new'
  get '/signin', to: 'sessions#new'
  post '/sessions', to: 'sessions#create'
  post '/signout', to: 'sessions#destroy'

  get 'uploads/storage_service_urls'

  resources :articles
end
