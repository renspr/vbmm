DiavelforumMemberMap::Application.routes.draw do

  resources :members

  root to: redirect('/members')

end
