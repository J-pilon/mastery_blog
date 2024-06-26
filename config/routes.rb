Rails.application.routes.draw do
  root 'articles#index'

  get '/signup', to: 'registrations#new'
  post '/signup', to: 'registrations#create'
  get '/signin', to: 'sessions#new'
  post '/sessions', to: 'sessions#create'
  post '/signout', to: 'sessions#destroy'

  get 'uploads/storage_service'

  resource :profile, only: %i[show edit update], controller: 'profile'

  resource :users do
    resource :password, only: %i[new create edit update], controller: 'password' do
      get '/email-sent', to: 'password#email_sent'
    end
  end

  get '/articles/category', to: 'articles#index_by_category', as: 'articles_by_category'
  resources :articles do
    member do
      post :publish
    end
  end
end
