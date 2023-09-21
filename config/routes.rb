Rails.application.routes.draw do
  get 'sign-up', to: 'registration#new'
  post 'sign-up', to: 'registration#create'

  get 'upload_handler/presigned_url'

  root "homepage#index"

  resources :articles
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
