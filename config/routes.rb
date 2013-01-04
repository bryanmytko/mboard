Mboard::Application.routes.draw do
 
  root :to => "home#index"
  
  match 'topic/:slug' => 'replies#show', :as => :topic, :constraints => { :slug => /.*/ }
  match 'remove_topic/:id' => 'topics#destroy', :as => :remove_topic
  match 'user/:author' => 'users#show', :as => :user
  
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'session#new', as: 'login'
  get 'logout', to: 'session#destroy', as: 'logout'
  get 'chat', to: 'chats#index', as: 'chat'
  
  resources :users
  resources :session
  resources :topics, :constraints => { :topic => /.*/ }
  resources :replies
  resources :notifications
  resources :likes
  resources :chats

end
