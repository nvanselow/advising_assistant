Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root 'advisees#index', as: :authenticated_root
  end

  root 'home#index'

  get "/auth/:provider/callback" => 'identities#create'

  resources :advisees do
    resources :graduation_plans, only: [:index, :new, :create]
  end

  resources :graduation_plans, only: [:show]

  resources :meetings, only: [:show, :edit, :update, :destroy] do
    resources :meeting_summaries, only: [:create]
  end

  namespace :api do
    namespace :v1 do
      resources :all_meetings, only: [:index]
      resources :google_calendars, only: [:index]
      resources :microsoft_calendars, only: [:index]
      resources :notes, only: [:update, :destroy]
      resources :search_advisees, only: [:index]
      resources :upcoming_meetings, only: [:index]
      resources :courses, only: [:update, :destroy]

      resources :advisees, only: [] do
        resources :advisee_notes, only: [:index, :create]
        resources :meetings, only: [:index, :create]
      end

      resources :meetings, only: [:update, :destroy] do
        resources :meeting_notes, only: [:index, :create]
        resources :google_calendars, only: [:create]
        resources :microsoft_calendars, only: [:create]
      end

      resources :graduation_plans, only: [:update] do
        resources :semesters, only: [:index]
      end

      resources :semesters, only: [] do
        resources :courses, only: [:create]
      end
    end
  end
end
