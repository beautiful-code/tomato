Tomato::Application.routes.draw do
  
  resources :restaurants do 
  	resources :reviews do 
      resources :notes ,only: [:edit,:create,:update,:new,:destroy]
  		collection do
  			get 'zomato'
  			get 'burrp'
  			get 'yelp'
        match "/yelp", to: "notes#create",as: :create_note
        match "/yelp", to: "notes#destroy",as: :destroy_note
        match "/yelp", to: "notes#edit",as: :edit_note
        match "/yelp", to: "notes#update",as: :update_note
  		end
  	end
  end
  
  root :to => 'restaurants#index'


end
