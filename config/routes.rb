Tomato::Application.routes.draw do
  get "notes/item:string"

  get "notes/score:float"

  get "notes/review:references"

  resources :restaurants do 
  	resources :reviews do 
  		collection do
  			get 'zomato'
  			get 'burrp'
  			get 'yelp'
  		end
  	end
  end
  
  root :to => 'restaurants#index'

end
