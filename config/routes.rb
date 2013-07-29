ApiKjdbCom::Application.routes.draw do
  root 'home#index'

  resources :songbooks, only: [:index, :show]

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
