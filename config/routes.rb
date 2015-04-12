Rails.application.routes.draw do
  resources :alerts

  resources :allies, :except => [:show, :new, :create, :edit, :update, :destroy] do
    collection do
      post "add"
      post "remove"
    end
  end

  resources :medications

  resources :moods

  resources :categories

  resources :triggers do
    collection do
      post "comment"
      post "support"
      get "allies" 
   end
  end

  resources :strategies do
    collection do
      post "comment"
      post "support"
    end
  end

  resources :profile, :except => [:show, :new, :create, :edit, :update, :destroy]

  resources :search, :except => [:show, :new, :create, :edit, :update, :destroy]

  get 'pages/home'
  #get 'pages/about', as: 'about'
  match 'about', to: 'pages#about', via: :get
  match '/triggers/allies', to: 'triggers#allies', via: :post
  devise_for :users, :controllers => { :registrations => :registrations, :omniauth_callbacks => 'omniauth_callbacks' }

  mount Ckeditor::Engine => "/ckeditor"

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
