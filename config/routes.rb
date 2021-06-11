Rails.application.routes.draw do
  root to: 'items#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :items do
    resources :comments, only: :create
    resources :purchases, only: [:index, :create]
    resource :likes, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end
  resources :users, only: [:show, :edit, :update]
  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'
end
