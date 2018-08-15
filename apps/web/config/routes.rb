root to: 'calendars#index'

resources :calendars, only: [:index, :show, :new]
post '/calendars', to: 'calendars#create'
