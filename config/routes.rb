Rails.application.routes.draw do

  root :to => redirect('/movies')
  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :movies do
    resources :votes , only: [:create, :destroy]
  end
end
