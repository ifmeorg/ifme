Rails.application.routes.draw do
  get 'errors/not_found'
  get 'errors/internal_server_error'

  get '/404' => 'errors#not_found'
  get '/500' => 'errors#internal_server_error'

  resources :allies, only: :index do
    collection do
      post 'add'
      post 'remove'
    end
  end

  resources :comment, only: [:create, :destroy] do
    collection do
      post 'create'
      delete 'delete'
    end
  end

  resources :medications

  resources :moods do
    collection do
      post 'premade'
      post 'quick_create'
    end
  end

  resources :categories do
    collection do
      post 'premade'
      post 'quick_create'
    end
  end

  resources :moments

  resources :secret_shares, only: [:create, :show, :destroy]

  resources :strategies do
    collection do
      post 'premade'
      post 'quick_create'
    end
  end

  resources :groups do
    scope module: :groups do
      resource :membership, only: [:create, :destroy] do
        delete ':member_id', to: 'memberships#kick', as: 'kick'
      end
    end
  end

  resources :meetings do
    collection do
      get 'join'
      get 'leave'
    end
  end

  resources :profile, only: :index do
    collection do
      post 'add_ban'
      post 'remove_ban'
    end
  end

  resources :reports, only: [:create, :new] do
    collection do
      get 'admin_dashboard'
    end
  end

  resources :search, only: :index do
    collection do
      get 'posts'
    end
  end

  resources :notifications, only: [:destroy, :index] do
    collection do
      delete 'clear'
      get 'fetch_notifications'
      get 'signed_in'
    end
  end

  get 'pages/home'
  match 'about', to: 'pages#about', via: :get
  match 'admin_dashboard', to: 'pages#admin_dashboard', via: :get
  match 'contribute', to: 'pages#contribute', via: :get
  match 'partners', to: 'pages#partners', via: :get
  match 'privacy', to: 'pages#privacy', via: :get
  match 'faq', to: 'pages#faq', via: :get
  match 'toggle_locale', to: 'pages#toggle_locale', via: :post
  match 'press', to: 'pages#press', via: :get
  match 'resources', to: 'pages#resources', via: :get

  devise_for :users, controllers: { registrations: :registrations,
                                       omniauth_callbacks: 'omniauth_callbacks',
                                       invitations: 'users/invitations',
                                       sessions: :sessions }

  post 'pusher/auth'

  Rails.configuration.i18n.available_locales.each do |locale|
    get locale.to_s => 'locales#set_initial_locale', defaults: { locale: locale.to_s }
  end

  root 'pages#home'
end
