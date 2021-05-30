Rails.application.routes.draw do
  get 'purchases/index'
  get 'purchases/new'
  root to: 'items#index'
  devise_for :users
  resources :items do
    resources :purchases, only: [:index, :create]
  end
end
