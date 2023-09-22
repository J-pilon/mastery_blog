Rails.application.routes.draw do
  get 'signup', to: 'registration#new'
  post 'signup', to: 'registration#create'
  
  get 'signin', to: 'sessions#new'
  post 'signin', to: 'sessions#create'
  post 'signout', to: 'sessions#destroy'

  get 'upload_handler/presigned_url'

  root "homepage#index"

  resources :articles
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
