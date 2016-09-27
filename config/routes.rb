Rails.application.routes.draw do
  devise_for :users
  root 'prototypes#index'

  get  '/prototypes/index'  =>    'prototypes#index'

  resources :prototypes, only: [:new, :create, :show, :edit, :update, :destroy] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end

  resources :users, only: [:show, :edit, :update]
end
