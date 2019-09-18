Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "users#welcome"

  devise_for :users, :controllers => { :registrations => "registrations" }

  resources :users do
    member do
      get :profile
    end
  end

  resources :services do
  end

end
