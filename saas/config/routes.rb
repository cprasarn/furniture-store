Saas::Application.routes.draw do

  get "static_pages/home"
  get "static_pages/help"
  get "static_pages/contact"
  get "static_pages/about"

  match '/home' => 'static_pages#home'
  match '/help' => 'static_pages#help'
  match '/about' => 'static_pages#about'
  match '/contact' => 'static_pages#contact'
  match '/signin' => 'static_pages#signin'
  
  match '/orders/search' => 'orders#search'
  match '/customers/search' => 'customers#search'
  match '/customers_addresses/search' => 'customers_addresses#search'
  match '/items/search' => 'items#search'
  match '/items/list' => 'items#list'

  resources :states
  resources :customers
  resources :addresses
  resources :customers_addresses
  resources :orders
  resources :items
  resources :ledgers
  resources :roles
  resources :user_roles
  resources :notes
  resources :payment_types

end
