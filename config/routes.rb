Rails.application.routes.draw do
  get 'comments/create'

  get 'comments/destroy'

  root 'events#index'
  devise_for :users, controllers: { :omniauth_callbacks => "oauth_callbacks" }
  resources :users, only: [:index, :show]
  resources :events
  resources :attendances, only: [:create, :update]
  resources :shares, only: [:create]
  resources :searchs, only: [:create, :index]
  resources :comments, only: [:create, :destroy]
  resources :completions do
    get :autocomplete_tag_name, :on => :collection
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
