Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  root 'chatrooms#index'

  devise_for :users

  namespace :admin do
    root 'admin#index'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :posts, only: [:new, :create, :edit, :update, :destroy]
  resources :chatrooms
end
