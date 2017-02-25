Rails.application.routes.draw do
  get 'errors/not_found'
  get 'errors/internal_server_error'

  get "/404" => "errors#not_found"
  get "/500" => "errors#internal_server_error"

  resources :allies, :except => [:show, :new, :create, :edit, :update, :destroy] do
    collection do
      post "add"
      post "remove"
    end
  end

  resources :medications

  resources :moods do
    collection do
      post "premade"
      post "quick_create"
    end
  end

  resources :categories do
    collection do
      post "premade"
      post "quick_create"
    end
  end

  resources :moments do
    collection do
      post "comment"
      post "quick_moment"
      get "delete_comment"
    end
  end

  resources :strategies do
    collection do
      post "comment"
      post "premade"
      post "quick_create"
      get "delete_comment"
    end
  end

  resources :groups do
    collection do
      get "join"
      get "leave"
    end
  end

  resources :meetings do
    collection do
      get "join"
      get "leave"
      post "comment"
      get "delete_comment"
    end
  end

  resources :profile, :except => [:show, :new, :create, :edit, :update, :destroy]

  resources :search, :except => [:show, :new, :create, :edit, :update, :destroy] do
    collection do
      get "posts"
    end
  end

  resources :notifications, :except => [:show, :new, :create, :edit, :update] do
    collection do
      delete 'clear'
      get "fetch_notifications"
      get "signed_in"
    end
  end

  get 'pages/home'
  match 'about', to: 'pages#about', via: :get
  match 'contributors', to: 'pages#contributors', via: :get
  match 'partners', to: 'pages#partners', via: :get
  match 'blog', to: 'pages#blog', via: :get
  match 'privacy', to: 'pages#privacy', via: :get
  match 'faq', to: 'pages#faq', via: :get
  match 'toggle_locale', to: 'pages#toggle_locale', via: :get

  devise_for :users, :controllers => { :registrations => :registrations, :omniauth_callbacks => 'omniauth_callbacks', :invitations => 'users/invitations' }

  mount Ckeditor::Engine => "/ckeditor"

  post 'pusher/auth'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  root "pages#home"
end
