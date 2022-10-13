Rails.application.routes.draw do
  get 'upload_handler/presigned_url'

  root "homepage#index"

  resources :articles
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
