VBMM::Application.routes.draw do

  resource  :member,   only: [:edit, :update]
  delete    :member,   to: 'members#destroy'

  resources :sessions, only: [:new, :create]
  delete    :session,  to: 'sessions#destroy'

  get '/legal-info', to: 'static_pages#legal_info'
  get '/privacy',    to: 'static_pages#privacy'

  get '/members', to: 'application#map' # hack for old route that causes problems.
  root to: 'application#map'

end
