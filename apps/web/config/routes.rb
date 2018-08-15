root to: 'calendars#index'

resources :calendars, only: [:index, :show]
get '/calendars/new', to: 'calendars#new'
