Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'welcome#index'

  resources :users, only: [:show, :create]
  get '/dashboard', to: 'users#dashboard'

  get '/discover', to: 'movies#discover'

  get '/movies', to: 'movies#index'
  get '/movies/:movie_id', to: 'movies#show'

  get '/movies/:movie_id/viewing-party/new', to: 'viewing_parties#new'

  post '/viewing_parties', to: 'viewing_parties#create'

  get '/register', to: 'users#new'

  get '/login', to: 'session#new'
  post '/login', to: 'session#create'
  get '/logout', to: 'session#destroy'
end
