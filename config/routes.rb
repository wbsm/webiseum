Webiseum::Application.routes.draw do

  # Landing Page paths
  root 'webiseum#index'

  # Auth paths
  get   '/signup', :to => 'sessions#new', :as => :signup
  get   '/logout', :to => 'sessions#destroy', :as => :logout
  match '/auth/:provider/callback', :to => 'sessions#create', via: [:get, :post]
  match '/auth/failure', :to => 'sessions#failure', via: [:get]

  # Landing page
  resources :webiseum, only: [:index] do
    collection do
      get :unregistered
    end
  end

  # Social module
  namespace :social do
    resources :feed, only: [:index] do
      collection do
        get :all_forecasts, :user_forecast
      end
      member do
        get :filter_by_tags
      end
    end

    resources :forecasts do
      collection do
        post :match
        get :rematch
      end
    end

    resources :profile, only: [:show, :edit, :update]
  end

  # Admin module
  namespace :admin do
    resources :dashboard, :questions, :users, :tags do
      collection do
        get 'search'
      end
    end

    resources :ranking_generator do
      collection do
        get 'generate'
      end
    end
  end

end
