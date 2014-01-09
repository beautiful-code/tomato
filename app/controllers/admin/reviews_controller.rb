class Admin::ReviewsController < ApplicationController
  before_filter :set_admin
  before_filter :authenticate_user!
  before_filter :authenticate_admin!
  before_filter :init_breadcrumb


  def show
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.find(params[:id])
    @feedbacks = @review.feedbacks

    # @users = @review.notes.select('distinct(user_id)').collect {|user_entry| User.find(user_entry.user_id) }

    add_breadcrumb @restaurant.name,admin_restaurant_path(@restaurant)
    if @review.source == 'Zomato'
      add_breadcrumb 'Reviews',zomato_admin_restaurant_reviews_path
    end
    if @review.source == 'Yelp'
      add_breadcrumb 'Reviews',yelp_admin_restaurant_reviews_path
    end
    if @review.source == 'Burrp'
      add_breadcrumb 'Reviews',burrp_admin_restaurant_reviews_path
    end
    add_breadcrumb "#{@review.id}",admin_restaurant_review_path(@restaurant,@review)
  end

  def zomato
    @restaurant = Restaurant.find(params[:restaurant_id])
    @reviews = @restaurant.reviews.where(source:'Zomato').order('review_created_at DESC').page(params[:page]).per(10)
    add_breadcrumb @restaurant.name,admin_restaurant_path(@restaurant)
    add_breadcrumb 'Zomato',zomato_admin_restaurant_reviews_path
    @source = 'zomato'
    render 'reviews/source_reviews'
  end

  def burrp
    @restaurant = Restaurant.find(params[:restaurant_id])
    add_breadcrumb @restaurant.name,admin_restaurant_path(@restaurant)
    add_breadcrumb 'Burrp',burrp_admin_restaurant_reviews_path
    @reviews = @restaurant.reviews.where(source:'Burrp').order('review_created_at DESC').page(params[:page]).per(10)
    @source = 'burrp'
    render 'reviews/source_reviews'
  end

  def yelp
    @restaurant = Restaurant.find(params[:restaurant_id])
    add_breadcrumb @restaurant.name,admin_restaurant_path(@restaurant)
    add_breadcrumb 'Yelp',yelp_admin_restaurant_reviews_path
    @reviews = @restaurant.reviews.where(source:'Yelp').order('review_created_at DESC').page(params[:page]).per(10)
    @source = 'yelp'
    render 'reviews/source_reviews'
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    flash[:notice] = 'Successfully deleted the review.'
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
end
