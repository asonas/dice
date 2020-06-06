Rails.application.routes.draw do
  resources :rooms, param: :uuid do
    resources :messages
  end
  resources :charactors, only: %i[new create]

  mount ActionCable.server => '/cable'
end
