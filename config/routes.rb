# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root controller: :application, action: :index
  resources :r, controller: :redirects, param: :shortened_url, only: [:show]
  resources :stats, param: :shortened_url, only: [:show, :index]
  resources :urls, param: :shortened_url, only: [:create, :show, :index]

end
