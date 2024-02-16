Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :api do
    namespace :v1 do
      resources :orders, shallow: true do
        post :add_inventory, on: :member
        post :add_payment, on: :member
        get :resume, on: :collection
      end
      resources :brands, shallow: true do
        resources :models
      end
      resources :motorcycles, shallow: true do
        get :list, on: :collection
      end
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
