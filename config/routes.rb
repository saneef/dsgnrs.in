DsgnrsIn::Application.routes.draw do
  resources :users
  # will give routes for users:
  # index, new, create, show, edit, update, destroy

  get "sessions/create"
  get "sessions/destroy"

  match "/auth/twitter/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout
  match '/auth/failure' => "sessions#failure"

  get "/apply" => "users#edit", :as => :apply
  get "/profile" => "users#edit", :as => :profile

  match "/:city", :to => 'users#index', :as => :city
  root :to => 'users#index'
end
