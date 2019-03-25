# frozen_string_literal: true

Rails.application.routes.draw do
  get 'stats/index'
  get 's/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#index'
  resources :s, only: [:index]
  resource :stats, only: [:index]
  resource :urls

end
