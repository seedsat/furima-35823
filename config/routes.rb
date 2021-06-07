Rails.application.routes.draw do
  root to: 'items#index'
  devise_for :users
  resources :items do
    resources :purchases, only: [:index, :create]
    collection do
      get 'search'
    end
  end
end
