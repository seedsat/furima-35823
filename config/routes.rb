Rails.application.routes.draw do
  root to: 'items#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :items do
    resources :purchases, only: [:index, :create]
    collection do
      get 'search'
    end
  end
  resources :users, only: [:show, :edit, :update]
end
