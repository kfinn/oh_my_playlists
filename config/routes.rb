Rails.application.routes.draw do
  devise_for :subscribers, controllers: { omniauth_callbacks: 'subscribers/omniauth_callbacks' }
  root to: 'homes#show'
  resource :home, only: :show
  get '/users/auth/spotify/ios_callback' => redirect('/')

  resources :playlists, only: :index do
    resources :playlist_watches, only: :create
  end
  resources :playlist_watches, only: :index do
    resources :playlist_snapshots, only: :create
  end
  resources :artist_appearances, only: :index
end
