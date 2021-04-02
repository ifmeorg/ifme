# frozen_string_literal: true
require 'sidekiq/web'
require 'sidekiq/cron/web'
Rails.application.routes.draw do
  get 'errors/not_found'
  get 'errors/internal_server_error'

  get '/404' => 'errors#not_found'
  get '/500' => 'errors#internal_server_error'

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :allies, only: :index do
    collection do
      post 'add'
      post 'remove'
    end
  end

  resources :comments, only: %i[create delete] do
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

  resources :moments do
    collection do
      post 'picture', to: 'moments#picture', as: 'picture'
      get 'tagged', defaults: { format: 'json' }
    end
  end

  resources :secret_shares, only: %i[create show destroy]

  resources :strategies do
    collection do
      post 'premade'
      post 'quick_create'
      get 'tagged', defaults: { format: 'json' }
    end
  end

  resources :groups do
    scope module: :groups do
      resource :membership, only: %i[create destroy] do
        delete ':member_id', to: 'memberships#kick', as: 'kick'
      end
    end
  end

  resources :meetings do
    collection do
      get 'join'
      get 'leave'
    end
    resource :google_calendar_event, controller: 'meetings/google_calendar_event', only: %i[create destroy]
  end

  match 'care_plan', to: 'care_plan#index', via: :get

  match 'care_plan_contacts/create', to: 'care_plan_contacts#create', via: :post
  match 'care_plan_contacts/update', to: 'care_plan_contacts#update', via: :patch
  match 'care_plan_contacts/destroy', to: 'care_plan_contacts#destroy', via: :delete

  match 'moment_templates', to: 'moment_templates#index', via: :get

  match 'moment_templates/create', to: 'moment_templates#create', via: :post
  match 'moment_templates/update', to: 'moment_templates#update', via: :patch
  match 'moment_templates/destroy', to: 'moment_templates#destroy', via: :delete

  resources :profile, only: :index do
    collection do
      post 'add_ban'
      post 'remove_ban'
      get 'data', defaults: { format: 'json' }
    end
  end

  resources :reports, only: %i[create new] do
    collection do
      get 'admin_dashboard'
    end
  end

  resources :search, only: :index do
    collection do
      get 'posts'
    end
  end

  resources :notifications, only: %i[destroy index] do
    collection do
      delete 'clear'
      get 'fetch_notifications'
      get 'signed_in'
    end
  end

  resources :omniauth_callbacks do
    collection do
      get 'omniauth_login'
    end
  end

  get 'pages/home'
  match 'about', to: 'pages#about', via: :get
  match 'admin_dashboard', to: 'pages#admin_dashboard', via: :get
  match 'partners', to: 'pages#partners', via: :get
  match 'privacy', to: 'pages#privacy', via: :get
  match 'faq', to: 'pages#faq', via: :get
  match 'toggle_locale', to: 'pages#toggle_locale', via: :post
  match 'press', to: 'pages#press', via: :get
  match 'resources', to: 'pages#resources', via: :get
  get 'home_data', to: 'pages#home_data', defaults: { format: 'json' }

  devise_for :users, controllers: { registrations: :registrations,
                                    omniauth_callbacks: 'omniauth_callbacks',
                                    invitations: 'users/invitations',
                                    sessions: :sessions }

  namespace :users do
    post "/data" => "reports#submit_request"
    get  "/data/status" => "reports#fetch_request_status"
    get  "/data/download" => "reports#download_data"
  end

  post 'pusher/auth'

  Rails.configuration.i18n.available_locales.each do |locale|
    get locale.to_s => 'locales#set_initial_locale', defaults: { locale: locale.to_s }
  end

  root 'pages#home'
end
