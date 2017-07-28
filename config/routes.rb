# frozen_string_literal: true

Rails.application.routes.draw do
  resources :stocks, only: [:index, :show, :create, :update, :destroy]
  match '*path', :to => 'application#routing_error', via: [:get, :post, :delete, :put, :patch]
end
