Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:create]
  get 'user', to: 'users#show'
  post 'login', to: 'sessions#create'
  post 'logout', to: 'sessions#destroy'

  get '/rooms', to: 'rooms#index'
  post '/rooms', to: 'rooms#create'
  get '/rooms/:invite_code', to: 'rooms#show'
  patch '/rooms/:invite_code', to: 'rooms#join'

  post '/videos/:invite_code', to: 'videos#create'
  get '/video/:id', to: 'videos#show'
  get '/videos/:invite_code', to: 'videos#index'
end
