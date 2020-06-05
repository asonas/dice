Rails.application.routes.draw do
  resources :rooms, param: :uuid do
    resources :messages
  end

  mount ActionCable.server => '/cable'
end
