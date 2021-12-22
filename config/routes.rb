Rails.application.routes.draw do
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :sessions, only: [:create]
  get :login, to: "sessions#new", as: "new_hotel_session"
  delete :logout, to: "sessions#destroy", as: "destroy_session"
end
