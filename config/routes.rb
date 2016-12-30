# rubocop:disable Metrics/BlockLength
Rails.application.routes.draw do
  get 'errors/not_found'
  get 'errors/internal_server_error'

  get '/404' => 'errors#not_found'
  get '/500' => 'errors#internal_server_error'

  resources :allies, only: :index do
    collection do
      post :add
      post :remove
    end
  end

  resources :medications

  resources :moods do
    collection do
      post :premade
      post :quick_create
    end
  end

  resources :categories do
    collection do
      post :premade
      post :quick_create
    end
  end

  resources :moments do
    collection do
      post :quick_moment
    end
  end

  resources :strategies do
    collection do
      post :premade
      post :quick_create
    end
  end

  resources :groups do
    collection do
      get :join
      get :leave
    end
  end

  resources :meetings do
    collection do
      get :join
      get :leave
    end
  end

  resources :profile, only: :index
  resources :comments, only: [:create, :destroy]

  resources :search, only: :index do
    get :posts, on: :collection
  end

  resources :notifications, only: :destroy do
    collection do
      delete :clear

      get :fetch_notifications
      get :signed_in
    end
  end

  get 'pages/home'
  match 'about', to: 'pages#about', via: :get
  match 'contributors', to: 'pages#contributors', via: :get
  match 'partners', to: 'pages#partners', via: :get
  match 'blog', to: 'pages#blog', via: :get
  match 'privacy', to: 'pages#privacy', via: :get
  match 'faq', to: 'pages#faq', via: :get

  # controller for the letsencrypt ssl cert challenge
  get '.well-known/acme-challenge/:id' => 'pages#letsencrypt'

  devise_for :users, controllers: {
    registrations: :registrations, omniauth_callbacks: 'omniauth_callbacks',
    invitations: 'users/invitations'
  }

  mount Ckeditor::Engine => '/ckeditor'

  post 'pusher/auth'

  root 'pages#home'
end
