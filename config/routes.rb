DiavelforumMemberMap::Application.routes.draw do

  resource  :member,   only: [:edit, :update]
  delete    :member,   to: 'members#destroy'

  resources :sessions, only: [:new, :create]
  delete    :session,  to: 'sessions#destroy'

  root to: 'application#map'

end
