Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :advisees, only: [:index, :show, :new, :create]
end
