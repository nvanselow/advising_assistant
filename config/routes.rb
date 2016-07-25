Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root 'advisees#index', as: :authenticated_root
  end

  root 'home#index'

  get "/auth/:provider/callback" => 'identities#create'

  resources :advisees
  resources :meetings, only: [:show]

  namespace :api do
    namespace :v1 do
      resources :google_calendars, only: [:index]
      resources :microsoft_calendars, only: [:index]
      resources :notes, only: [:update, :destroy]
      resources :search_advisees, only: [:index]
      resources :upcoming_meetings, only: [:index]

      resources :advisees, only: [] do
        resources :advisee_notes, only: [:index, :create]
        resources :meetings, only: [:index, :create]
      end

      resources :meetings, only: [:update, :destroy] do
        resources :meeting_notes, only: [:index, :create]
        resources :google_calendars, only: [:create]
        resources :microsoft_calendars, only: [:create]
      end
    end
  end
end
