Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  devise_scope :user do
    get 'sign_in', to: 'users/sessions#new'
    post 'sign_in', to: 'users/sessions#create'
    delete 'sign_out', to: 'users/sessions#destroy'
    get 'users/edit', to: 'home#user_edit', as: 'edit_user_registration'
    patch 'users', to: 'users/registrations#update', as: 'user_registration'
    get 'project_details', to: 'home#project_details'
  end
  ActiveAdmin.routes(self)
  root to: 'home#index'
end
