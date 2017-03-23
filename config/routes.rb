Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


get "homes/sample/:id" => "homes#sample"
resources :homes, :only => [:index]
  
  match ':controller(/:action(/:id))', via: [ :get, :post, :patch ]
end
