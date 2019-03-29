# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root controller: :application, action: :index
  resources :s, only: [:show]
  resources :stats, only: [:show, :index]
  resources :urls, only: [:create, :show, :index]

end
