Sb::Application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]

  resources :statuses
  resources :users
  
  resources :services do
    resources :events
  end
  
  match '/signup',   to: 'users#new'
  match '/signin',   to: 'sessions#new'
  match '/signout',  to: 'sessions#destroy'
  match '/home',     to: 'static_pages#home'
  match '/about',     to: 'static_pages#about'
  
  root to: 'sessions#new'

end