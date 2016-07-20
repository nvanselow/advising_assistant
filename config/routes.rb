Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :advisees

  namespace :api do
    namespace :v1 do
      resources :search_advisees, only: [:index]
    end
  end
end
