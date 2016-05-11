Rails.application.routes.draw do
  get 'users/show'
  get 'users/index'
  get 'pages/home'

  devise_for :users, controllers: { :omniauth_callbacks => "oauth_callbacks" }
  root 'pages#home'

  resources :users, only: [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
