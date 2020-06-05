Rails.application.routes.draw do
  resources :rooms, param: :uuid
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
