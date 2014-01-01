class Admin::RestaurantsController < ApplicationController
  before_filter :set_admin
  before_filter :authenticate_user!
  before_filter :authenticate_admin!

  def index
    @restaurants = Restaurant.all
    @restaurants = Kaminari.paginate_array(@restaurants).page(params[:page]).per(5)
    @review = Review.new
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @reviews = @restaurant.reviews
    @review = Review.new(restaurant_id: @restaurant.id)

    render 'restaurants/show'
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
      redirect_to admin_restaurant_path(@restaurant), notice: 'Restaurant was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update_attributes(params[:restaurant])
      redirect_to admin_restaurant_path(@restaurant), notice: 'Restaurant was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    redirect_to admin_restaurants_path
  end

  private
    def authenticate_admin!
      redirect_to root_path, alert: "Admin area restricted !"  unless admin?
    end

    def admin?
      current_user.has_role? :admin
    end
end
