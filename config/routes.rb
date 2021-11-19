Rails.application.routes.draw do
  devise_for :users
  root 'grid#index'
end
