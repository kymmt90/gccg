root to: 'calendars#index'

resources :calendars, only: [:index, :show, :new, :create, :edit]
patch '/calendars/:id', to: 'calendars#update'
