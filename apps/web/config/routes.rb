root to: 'calendars#index'

resources :calendars, only: [:index, :show, :new, :create, :edit, :update]
delete '/calendars/:id', to: 'calendars#destroy'
