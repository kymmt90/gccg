root to: 'calendars#index'

resources :calendars, only: [:index]
get '/calendars/:id', to: 'calendars#show'
