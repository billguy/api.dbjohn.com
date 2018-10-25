Rails.application.routes.draw do

  mount ActionCable.server => '/cable'

  resources :signins, only: [:create, :destroy]
  resources :users, only: [:index, :show, :create, :update, :destroy]
  resources :posts, only: [:index, :show, :create, :update, :destroy]
  resources :blog_posts, only: :index
  resources :pics, only: [:index, :show, :create, :update, :destroy]
  resources :assets, only: [:index, :show, :create, :destroy]

end
