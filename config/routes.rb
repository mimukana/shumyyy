Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'tweets/result' => 'tweets#result'
  get 'tweets/music' => 'tweets#music'
  get 'tweets/cooking' => 'tweets#cooking'
  get 'tweets/anime' => 'tweets#anime'
  resources :users, only: [:show] # ユーザーマイページへのルーティング

  resources :perfumes

  resources :tweets do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end
  
 
  root 'tweets#index'
end
