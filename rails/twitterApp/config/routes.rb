Rails.application.routes.draw do
  resources :tweets
  devise_for :users
  get 'home/index'
  get 'home/follow'
  get '/home/other/:id', to: 'home#other'
  post 'relationship/create', as: 'relationships'
  post 'home/append'
  post 'home/count_tweets'
  post 'home/append_new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"
end
