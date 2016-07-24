Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  get "/auth/:provider/callback" => 'identities#create'

  resources :advisees

  namespace :api do
    namespace :v1 do
      resources :search_advisees, only: [:index]

      resources :advisees, only: [] do
        resources :advisee_notes, only: [:index, :create]
        resources :meetings, only: [:index, :create]
      end

      resources :advisee_notes, only: [:update, :destroy]
      resources :meetings, only: [:update, :destroy]
      resources :google_calendars, only: [:index]
    end
  end
end
