Rails.application.routes.draw do
  root "application#login"
  get "/login" => "logins#new"
  post "/login" => "logins#create"
  get "/logout" => "logins#destroy"
  resources :users, only: [:index, :edit, :update]
  resources :attendances, only: [:create, :update]
  namespace :admin do
    resources :users do
      put "lock"
      put "unlock"
    end
    resources :attendances, only: [:update, :destroy]
  end
  resources :change_passwords, only: [:edit, :update]
  get "*path" => redirect("/")
end
