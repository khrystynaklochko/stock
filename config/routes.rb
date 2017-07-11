# frozen_string_literal: true

Rails.application.routes.draw do
  resources :stocks, only: [:index, :show]
end
