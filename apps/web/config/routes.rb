root to: 'calendars#index'

resources :calendars, only: [:index, :show, :new, :create]
