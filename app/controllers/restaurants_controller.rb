class RestaurantsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :init_breadcrumb

  def index
    @restaurants = Restaurant.page(params[:page]).per(10)
    @review = Review.new
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    add_breadcrumb @restaurant.name,restaurant_path(@restaurant)
    @reviews = @restaurant.reviews
    @review = Review.new(restaurant_id: @restaurant.id)
  end

  def new
    @restaurant = Restaurant.new
    add_breadcrumb 'New Restaurant',new_restaurant_path
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
    add_breadcrumb @restaurant.name,restaurant_path(@restaurant)
    add_breadcrumb 'Edit Restaurant',new_restaurant_path(@restaurant)
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

  private
    def init_breadcrumb
      add_breadcrumb 'All Restaurants', restaurants_path
    end
end
