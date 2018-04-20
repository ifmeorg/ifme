Dummy::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  resources :posts
  root :to => "posts#index"
end
