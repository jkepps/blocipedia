Rails.application.routes.draw do
  get 'subcriptions/new'

  get 'users/show'

  root to: 'welcome#index'

  devise_for :users

  resources :users, only: :show

  resources :wikis

  resources :subscriptions, only: [:new, :create, :destroy]
end
