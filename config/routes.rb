Rails.application.routes.draw do
  get 'users/show'
  get 'users/index'
  get 'pages/home'
  post 'search_event' => 'events#search'
  post 'event/share/:id' => 'events#share', as: 'share_event'

  devise_for :users, controllers: { :omniauth_callbacks => "oauth_callbacks" }
  root 'events#index'

  resources :users, only: [:index, :show]
  resources :events
  resources :attendances, only: [:create, :update]
  resources :shares, only: [:create]
  resources :searchs, only: [:create, :index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
