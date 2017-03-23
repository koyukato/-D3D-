Rails.application.routes.draw do
  resources :recipe
  match ':controller(/:action(/:id))', via: [ :get, :post, :patch ]
end
