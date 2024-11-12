SampleApp::Application.routes.draw do
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }
  resources :users do
    member do
      get :following, :followers
    end
  end
  #get "/auth/:provider/callback" => "oauth_sessions#create"
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  
  resources :sessions,      only: [:new, :create, :destroy]
  resources :microposts,    only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  resources :favorite, only: [:create, :destroy, :get]
  resources :followup, only: [:create, :patch, :get, :put, :destroy]
  resources :metoo, only: [:create, :destroy]

  get 'micropost_search' => 'search#search'
  get 'user_search' => 'search#usersearch'

  get 'micropost_filter' => 'search#filter'
  #get 'user_filter' => 'search#userfilter'
  get 'followall' => 'relationships#followall'

  match '/search' => 'search#search', via: [:get, :patch]

  root to: 'static_pages#home'
  #match '/signup',  to: 'users#new',            via: 'get'
#  match '/signin',  to: 'sessions#new',         via: 'get'
#  match '/signout', to: 'sessions#destroy',     via: 'delete'
#  match '/help',    to: 'static_pages#help',    via: 'get'
#  match '/about',   to: 'static_pages#about',   via: 'get'
#  match '/contact', to: 'static_pages#contact', via: 'get'
end
