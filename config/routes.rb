Rails.application.routes.draw do
	resources :recipe, :only => ['index']
	match ':controller(/:action(/:id))', via: [ :get, :post, :patch ]

	 post "recipe/detail/" => "recipe#detail"
end
