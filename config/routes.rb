Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :api do
    namespace :v1 do
      resources :orders, shallow: true do
        post :add_inventory, on: :member
        post :add_payment, on: :member
      end
      resources :brands
      resources :models
      resources :motorcycles
      resources :drivers
      resources :customers, shallow: true do
        post :add_address, on: :member
      end
      resources :users, shallow: true do
        post :register, on: :collection
      end
    end
  end
end
