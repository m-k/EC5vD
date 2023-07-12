# frozen_string_literal: true

Rails.application.routes.draw do
  resources :orders, only: :update
  root 'orders#index'
end
