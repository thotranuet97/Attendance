Rails.application.routes.draw do
  root "application#login"
  get "/login" => "logins#new"
  post "/login" => "logins#create"
  get "/logout" => "logins#destroy"
  resources :users, only: [:show, :edit, :update]
  resources :attendances, only: [:create, :update, :destroy]
  namespace :admin do
    resources :users do
      put "lock"
      put "unlock"
    end
  end

end
