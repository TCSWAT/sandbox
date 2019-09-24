Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "users#welcome"

  devise_for :users, :controllers => { :registrations => "registrations"}

  resources :users do
    member do
      get :profile
    end
  end

  resources :services do
  end

  resources :clients do
  end

  get 'docs' => 'docs#index', as: :docs

  namespace :api do
    namespace :v1 do

      devise_scope :user do
        post 'login' => 'user_sessions#login'
      end

      resources :clients

      resources :users do
        collection do
          post :profile
        end
      end

      resources :services do
        collection do
          post :weather
        end
      end

    end
  end
end
