Codestock::Application.routes.draw do
  resources :sessions, :only => [:new, :create]
  match 'signin', :to => 'sessions#new', :as => :signin
  
  root :to => 'authenticated#index'
end
