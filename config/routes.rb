# frozen_string_literal: true

Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, ActiveAdmin::Devise.config

  devise_scope :user do
    get 'sign_in', to: 'users/sessions#new'
    post 'sign_in', to: 'users/sessions#create'
    delete 'sign_out', to: 'users/sessions#destroy'
    get 'users/edit', to: 'home#user_edit', as: 'edit_user_registration'
    patch 'users', to: 'users/registrations#update', as: 'user_registration'
  end

  root to: 'home#index'
  resources :tasks
  resources :comments
  get 'my_tasks', to: 'home#my_tasks'
  post 'create_project_user_task', to: 'home#create_project_user_task'
  get 'project_details', to: 'home#project_details'
  delete 'profile_picture', to: 'home#profile_picture'
end
