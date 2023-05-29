Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  resources :books, only: [:new, :edit, :create, :index, :show, :destroy, :update]
  resources :users, only: [:show, :edit, :index, :update]
  get 'home/about' => 'homes#about', as: 'about'
end
