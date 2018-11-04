Rails.application.routes.draw do

  mount ActionCable.server => '/cable'

  resources :signins, only: [:create, :destroy]
  resources :users, only: [:index, :show, :create, :update, :destroy]
  resources :posts, only: [:index, :show, :create, :update, :destroy]
  resources :blog_posts, only: [:index, :show, :create, :update, :destroy]
  resources :pics, only: [:index, :show, :create, :update, :destroy]
  resources :slogans, only: [:index, :show, :create, :update, :destroy]
  resources :assets, only: [:index, :show, :create, :destroy]
  resources :contacts, only: :create

  post '/rails/active_storage/direct_uploads', to: 'direct_uploads#create' # Rails API workaround for csrf

end
