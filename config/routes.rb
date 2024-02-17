Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :api do
    namespace :v1 do
      resources :orders, shallow: true do
        post :add_inventory, on: :member
        post :add_payment, on: :member
        get :resume, on: :collection
        get :clothing_types, on: :collection
        post :update_status, on: :member
      end
      resources :brands, shallow: true do
        resources :models
      end
      resources :motorcycles, shallow: true do
        get :list, on: :collection
      end
      resources :drivers, shallow: true do
        get :order, on: :member
        get :order_list, on: :member
      end
      resources :customers, shallow: true do
        post :add_address, on: :member
        get :address, on: :member
        get :order_list, on: :member
        post :address_show, on: :collection
      end
      resources :users, shallow: true do
        post :register, on: :collection
      end
    end
  end
end
