DsgnrsIn::Application.routes.draw do
  constraints(:host => "www.dsgnrs.in") do
    # Won't match root path without brackets around "*x". (using Rails 3.0.3)
    get "(*x)" => redirect { |params, request|
      URI.parse(request.url).tap { |x| x.host = "dsgnrs.in" }.to_s
    }
  end

  get "/feed", :to => 'syndicator#feed'

  resources :users
  # will give routes for users:
  # index, new, create, show, edit, update, destroy

  get "sessions/create"
  get "sessions/destroy"

  get "/sitemap", :to => 'sitemap#index', :as => :sitemap

  get "/auth/twitter/callback" => "sessions#create"
  get "/signout" => "sessions#destroy", :as => :signout
  get '/auth/failure' => "sessions#failure"

  get "/apply" => "users#edit", :as => :apply
  get "/profile" => "users#edit", :as => :profile
  get "/manage/(:status)", :to => 'users#index', :as => :filter

  get "/:city", :to => 'users#index', :as => :city
  root :to => 'users#index'
end
