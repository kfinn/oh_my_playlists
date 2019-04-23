Rails.application.routes.draw do
  root to: 'homes#show'
  resource :home, only: :show
end
