Rails.application.routes.draw do
  root 'journeys#index'

  resources :journeys
end
