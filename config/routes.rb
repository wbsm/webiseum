Webiseum::Application.routes.draw do

  # Landing Page paths
  root  'webiseum#index'


  # Login paths
  get   '/signup', to: 'sessions#new', as: :signup
  get   '/logout', to: 'sessions#destroy', as: :logout
  get   '/unregistered', to: 'webiseum#unregistered', as: 'unregistered'

  # Auth paths
  match '/auth/failure', :to => 'sessions#failure', via: [:get]
  match '/auth/:provider/callback', :to => 'sessions#create', via: [:get, :post]
  get   '/auth/new/:provider', to: 'sessions#new_user', as: 'new_user'

  # Feed and Social paths
  get   '/feed', to: 'social/feed#index', as: 'feed'
  get   '/questions', to: 'social/feed#question', as: 'feed_questions'
  get   '/forecasts/:id', to: 'social/feed#forecast', as: 'feed_forecasts'
  get   '/tags/:id', to: 'social/feed#tag', as: 'feed_tags'

  # Social Module
  namespace :social do
    resources :profile,           only: [:show, :edit, :update]
    resources :question,          only: [:show, :create]
    resources :question_forecast, only: [:create, :update]

    # refazer search
    resources :search,            only: [:search, :show] do
      collection do
        get '/', to: :search
      end
    end
  end

  # Admin module
  namespace :admin do
    get   '/ranking_generator', to: 'ranking_generator#generate'

    resources :dashboard, :questions, :users, :tags do
      collection do
        get 'search'
      end
    end
  end

end
