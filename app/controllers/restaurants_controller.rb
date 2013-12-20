class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
    @restaurants = Kaminari.paginate_array(@restaurants).page(params[:page]).per(5)
    @review = Review.new
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @reviews = @restaurant.reviews
    @review = Review.new(restaurant_id: @restaurant.id)
  end

  def new
    @restaurant = Restaurant.new
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def create
    @restaurant = Restaurant.new(params[:restaurant])
    if @restaurant.save
      redirect_to @restaurant, notice: 'Restaurant was successfully created.' 
    else
      render action: "new" 
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update_attributes(params[:restaurant])
      redirect_to @restaurant, notice: 'Restaurant was successfully updated.' 
    else
      render action: "edit" 
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    redirect_to restaurants_url 
  end
end
