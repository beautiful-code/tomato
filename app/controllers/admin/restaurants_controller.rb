class Admin::RestaurantsController < ApplicationController
  before_filter :set_admin
  before_filter :authenticate_user!
  before_filter :authenticate_admin!
  before_filter :init_breadcrumb

  def index
    @restaurants = Restaurant.page(params[:page]).per(5)
    @review = Review.new
    render 'restaurants/index'
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    add_breadcrumb @restaurant.name,admin_restaurant_path(@restaurant)
    @reviews = @restaurant.reviews
    @review = Review.new(restaurant_id: @restaurant.id)
    #compute_cluster_metrics

    render 'restaurants/show'
  end

  def new
    @restaurant = Restaurant.new
    add_breadcrumb 'New Restaurant',new_admin_restaurant_path

    render 'restaurants/new'
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
    add_breadcrumb @restaurant.name,admin_restaurant_path(@restaurant)
    add_breadcrumb 'Edit Restaurant',edit_admin_restaurant_path(@restaurant)
    render 'restaurants/edit'
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
      redirect_to request.referer, notice: 'Restaurant was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    redirect_to request.referer
  end

  private
    def authenticate_admin!
      redirect_to root_path, alert: "Admin area restricted !"  unless admin?
    end

    def admin?
      current_user.has_role? :admin
    end

    def init_breadcrumb
      add_breadcrumb 'Admin', admin_restaurants_path
      add_breadcrumb 'All Restaurants', admin_restaurants_path
    end

    def compute_cluster_metrics
      @clusters = @restaurant.clusters
    end

end
