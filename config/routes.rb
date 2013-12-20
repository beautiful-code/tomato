Tomato::Application.routes.draw do
  resources :restaurants do 
  	resources :reviews do 
  		collection do
  			get 'zomato'
  			get 'burrp'
  		end
  	end
  end
  
  root :to => 'restaurants#index'

end
