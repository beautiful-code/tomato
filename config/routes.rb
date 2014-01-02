Tomato::Application.routes.draw do
  
  devise_for :users
  namespace :admin do
    resources :restaurants do
      resources :reviews do
        resources :notes ,only: [:edit,:create,:update,:new,:destroy]
        collection do
          get 'zomato'
          get 'burrp'
          get 'yelp'
        end
      end
    end
  end
  resources :restaurants do 
  	resources :reviews do 
      resources :notes ,only: [:edit,:create,:update,:new,:destroy]
  		collection do
  			get 'zomato'
  			get 'burrp'
  			get 'yelp'
  		end
  	end
  end

  get '/users/notes', to: 'reviews#reviews'
  root :to => 'restaurants#index'


end

