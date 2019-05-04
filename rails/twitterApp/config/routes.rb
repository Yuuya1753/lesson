Rails.application.routes.draw do
  get '/uploads/tweet/image/:id/:file', :controller => 'home', :action => 'download'
  get '/uploads/user/icon/:id/:file', :controller => 'home', :action => 'download_icon'
  resources :tweets
  devise_for :users
  get 'home/index'
  get 'home/follow'
  get '/home/other/:id', to: 'home#other'
  post 'relationship/create', as: 'relationships'
  post 'home/append'
  post 'home/count_tweets'
  post 'home/append_new'
  get 'home/follower_list'
  get 'home/followee_list'
  get '/:account', to: 'home#other'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"
end
