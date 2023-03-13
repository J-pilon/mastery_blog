Rails.application.routes.draw do
  root "homepage#index"
  
  get 'users/signup', to: 'users#new'
  post 'users/create'

  get 'uploads/presigned_url'

  resources :articles
end
