Highlander::Application.routes.draw do

  # Redirect leaderboard.hooroo.com -> hooroo.hilander.io
  #
  match '(*foo)' => redirect { |p|
    "http://hooroo.hilander.io/#{p[:foo]}"
  },
  constraints: { host: 'leaderboard.hooroo.com' }, via: [ :get ]

  # Redirect thequickening.herokuapp.com -> www.hilander.io
  #
  match '(*foo)' => redirect { |p|
    "http://hilander.io"
  },
  constraints: { host: 'thequickening.herokuapp.com' }, via: [ :get ]

  namespace :api do

    Metric::NAMES.each do |metric|
      post metric => 'events#create', defaults: { metric: metric }
    end

    resources :events, only: [ :create ]

    namespace :adapters do
      resources :github,  only: [ :create ]
      resources :twitter, only: [ :create ]
    end
  end

  get   '/signout' => 'sessions#destroy', as: :signout
  get   '/auth/google_oauth2/callback' => 'sessions#create'
  get   '/auth/github/callback' => 'users#link_to_github'

  # get '/about' => 'high_voltage/pages#show', id: 'about'

  resources :registrations, only: [ :index, :create ]

  # Routes under this constraint are when no clan is being called
  # or it's www
  #
  constraints(Subdomain::Missing) do #lambda { |req| req.subdomain.blank? || req.subdomain == "www" }) do

    root to: 'registrations#index', as: 'root_register'

  end

  # Rounds under this constraint are for Organisations
  #
  # eg. Hooroo, Agile Aus
  #
  constraints(Subdomain::Present) do

    resources :users
    resources :badges, only: [ :index, :show ]
    resources :bounties
    resource  :clan

    get '/stats' => 'stats#index', as: :stats

    root to: 'welcome#index'

  end
end
