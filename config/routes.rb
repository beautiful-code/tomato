Tomato::Application.routes.draw do
  resources :restaurants do 
  	resources :reviews
  end
  
  root :to => 'restaurants#index'

end
