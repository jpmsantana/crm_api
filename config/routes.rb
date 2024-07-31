# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  resource :session, only: %i[show create]
  resources :customers

  namespace :admin do
    resources :users, only: %i[index create update destroy] do
      member do
        put :update_admin_status
      end
    end
  end
end
