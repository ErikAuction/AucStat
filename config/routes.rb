Rails.application.routes.draw do
  resources :auctions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  match '/importer',      to: 'importer#import',           via: 'get'
  match '/importer',      to: 'importer#import',        via: 'post'

  root to: "auctions#index"  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
