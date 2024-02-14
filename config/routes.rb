Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :api do
    namespace :v1 do
      resources :users, shallow: true do
        post :register, on: :collection
      end
    end
  end
end
