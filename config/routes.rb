Rails.application.routes.draw do
  get 'subcriptions/new'

  get 'users/show'

  root to: 'welcome#index'

  devise_for :users

  resources :users, only: :show

  resources :wikis do
  	resources :collaborators, only: [:create, :destroy]
  end

  resources :subscriptions, only: [:new, :create, :destroy]
end
