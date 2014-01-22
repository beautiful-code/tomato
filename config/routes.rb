Tomato::Application.routes.draw do
  
  devise_for :users
  get "user/feedbacks"

  namespace :admin do
    resources :restaurants do
      resources :reviews do
        resources :notes ,only: [:destroy]
        collection do
          get 'zomato'
          get 'burrp'
          get 'yelp'
          get 'foursquare'
        end
      end
    end
  end


  namespace :consumer do
    resources :restaurants, only: [] do
      member do
        get :overview
        post :overview
        get :restaurant
        get :features
        get :service
        get :dishes
        get :dish_chart
      end
    end
  end

  resources :restaurants do 
    resources :reviews do 
      member do
        get 'give_feedback'
      end
      collection do
        get 'zomato'
        get 'burrp'
        get 'yelp'
        get 'foursquare'
      end
    end
  end

  resources :feedbacks do
    resources :notes ,only: [:create,:destroy]
    resource :parameter, :only => :update
  end

  root :to => 'restaurants#index'
end

