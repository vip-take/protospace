Rails.application.routes.draw do
  devise_for :users
  root 'prototypes/populars#index'

  get  '/prototypes/index'  =>    'prototypes/populars#index'

  namespace :prototypes do
    resources :populars, only: [:index]
    resources :newests, only: [:index]
    resources :tags, only: [:index, :show]
  end

  resources :prototypes, only: [:new, :create, :show, :edit, :update, :destroy] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end

  resources :users, only: [:show, :edit, :update]
end
