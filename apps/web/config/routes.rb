root to: 'calendars#index'

resources :calendars, only: [:index, :show, :new, :create]
get '/calendars/:id/edit', to: 'calendars#edit'
