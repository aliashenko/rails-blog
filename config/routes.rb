Rails.application.routes.draw do
  devise_for :users

  resources :posts
  resources :users

  get 'admin/new_user' => 'users#admin_new'
  post 'users/admin_create' => 'users#admin_create'
  post 'users/admin_update' => 'users#admin_update'

  root "posts#index"
end
