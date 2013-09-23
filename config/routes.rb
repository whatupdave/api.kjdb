ApiKjdbCom::Application.routes.draw do
  root 'home#index'

  resources :songbooks, only: [:index, :show]

  get '/artist/:artist_id/album/:album_id/track/:id' => 'tracks#show', :as => :track

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
