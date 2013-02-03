DsgnrsIn::Application.routes.draw do
  get "users/apply"

  get "sessions/create"
  get "sessions/destroy"

  get "/apply" => "users#edit", :as => :apply
  get "/profile" => "users#edit", :as => :profile

  match "/auth/twitter/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout
  match '/auth/failure' => "sessions#failure"

  match "/:city", :to => 'home#index', :as => :city
  root :to => 'home#index'
end
