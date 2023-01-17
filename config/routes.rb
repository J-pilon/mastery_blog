Rails.application.routes.draw do
  get 'uploads/presigned_url'

  root "homepage#index"

  resources :articles
end
