Rails.application.routes.draw do
  

  resources :categories
  resource :shopping_cart, only: [:create, :show] do
    post :checkout
  end
  devise_for :users
  resources :listings do
    resources :orders, only: [:new, :create]
  end
  resources :sellers, only: [:create, :index, :update, :destroy]
  get 'pages/about'
  get 'pages/contact'
  get 'pages/home'
  get 'vendor' => 'listings#seller'
  get '/listings/:id' => 'listings#shop', as: 'shop' 
  get 'sales' => 'orders#sales'
  get 'purchases' => 'orders#purchases'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#home'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
