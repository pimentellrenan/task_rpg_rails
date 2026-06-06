Rails.application.routes.draw do
  root "dashboard#index"

  resource :registration, only: %i[new create]
  resource :session, only: %i[new create destroy]
  resources :projects
  resources :tasks do
    member do
      patch :complete
      patch :reopen
    end
  end

  namespace :api do
    post "capture", to: "captures#create"
  end
end
