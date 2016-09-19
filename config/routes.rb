Rails.application.routes.draw do
  devise_for :users
  root 'prototypes#index'

  get  '/prototypes/index'  =>    'prototypes#index'

  resources :prototypes, only: [:new, :create]
  resources :users, only: [:show, :edit, :update]
end
