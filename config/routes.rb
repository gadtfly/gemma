Rails.application.routes.draw do
  
  get 'shopping_cart_items/show'

  get 'shopping_cart_items/update'

  get 'shopping_cart_items/destroy'

  resources :categories
  resource :shopping_cart, only: [:create, :show, :destroy, :update] do
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
  get 'pages/designer', as: 'designer'
  get 'vendor' => 'listings#seller'
  get '/shop/:id' => 'listings#shop', as: 'shop' 
  get 'sales' => 'orders#sales'
  get 'purchases' => 'orders#purchases'
  get 'checkout' => 'shopping_carts#checkout', as: 'checkout'
  get 'cart' => 'shopping_carts#cart', as: 'cart'
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
