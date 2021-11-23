Rails.application.routes.draw do
  root 'game#index'
  resources :game do
    member do
      get 'crate_a_match'
      get 'connect_to_match'
    end
  end
  get '/match/:id', to: 'grid#index', as: 'match'
  devise_for :users
end
