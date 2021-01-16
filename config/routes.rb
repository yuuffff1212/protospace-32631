Rails.application.routes.draw do
  devise_for :users
  root to: "prototypes#index"
  post  "/prototypes/new"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :prototypes do
    resources :comments, only: :create
  end
  resources :users, only: :show
end
