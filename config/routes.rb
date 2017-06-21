Rails.application.routes.draw do
  root "application#login"
  get "/login" => "logins#new"
  post "/login" => "logins#create"
  get "/logout" => "logins#destroy"
  resources :users
  resources :attendances, only: [:create, :destroy]
end
