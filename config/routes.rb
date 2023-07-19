Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'welcome#index'

  resources :users, only: [:show, :create]

  get '/users/:id/discover', to: 'users#discover'
  get '/users/:id/movies', to: 'movies#index'
  get '/users/:id/movies/:movie_id', to: 'movies#show'
  get '/users/:id/movies/:movie_id/viewing-party/new', to: 'viewing_parties#new'

  post '/viewing_parties', to: 'viewing_parties#create'

  get '/register', to: 'users#new'

  get '/login', to: 'session#new'
  post '/login', to: 'session#create'
  get '/logout', to: 'session#destroy'

end
