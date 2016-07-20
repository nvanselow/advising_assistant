Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :advisees

  namespace :api do
    namespace :v1 do
      resources :search_advisees, only: [:index]

      resources :advisees, only: [] do
        resources :advisee_notes, only: [:index, :create]
      end

      resources :advisee_notes, only: [:update, :destroy]
    end
  end
end
