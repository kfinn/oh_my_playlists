Rails.application.routes.draw do
  devise_for :subscribers, controllers: { omniauth_callbacks: 'subscribers/omniauth_callbacks' }
  root to: 'homes#show'
  resource :home, only: :show
  get '/users/auth/spotify/ios_callback' => redirect('/')
end
