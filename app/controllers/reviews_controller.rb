class ReviewsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :init_breadcrumb

  def show
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.find(params[:id])
    add_breadcrumb @restaurant.name,restaurant_path(@restaurant)
    if @review.source == 'Zomato'
      add_breadcrumb 'Reviews',zomato_restaurant_reviews_path
    end
    if @review.source == 'Yelp'
      add_breadcrumb 'Reviews',yelp_restaurant_reviews_path
    end
    if @review.source == 'Burrp'
      add_breadcrumb 'Reviews',burrp_restaurant_reviews_path
    end
    add_breadcrumb "#{@review.id}",restaurant_review_path(@restaurant,@review)
  end

  def zomato
    @restaurant = Restaurant.find(params[:restaurant_id])
    add_breadcrumb @restaurant.name,restaurant_path(@restaurant)
    add_breadcrumb 'Zomato',zomato_restaurant_reviews_path
    @reviews = @restaurant.reviews.where(source:'Zomato').order('review_created_at DESC').page(params[:page]).per(4)
    @source = 'zomato'
    render 'source_reviews'
  end

  def burrp
    @restaurant = Restaurant.find(params[:restaurant_id])
    add_breadcrumb @restaurant.name,restaurant_path(@restaurant)
    add_breadcrumb 'Burrp',burrp_restaurant_reviews_path
    @reviews = @restaurant.reviews.where(source:'Burrp').order('review_created_at DESC').page(params[:page]).per(4)
    @source = 'burrp'
    render 'source_reviews'
  end

  def yelp
    @restaurant = Restaurant.find(params[:restaurant_id])
    add_breadcrumb @restaurant.name,restaurant_path(@restaurant)
    add_breadcrumb 'Yelp',yelp_restaurant_reviews_path
    @reviews = @restaurant.reviews.where(source:'Yelp').order('review_created_at DESC').page(params[:page]).per(4)
    @source = 'yelp'
    render 'source_reviews'
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    add_breadcrumb @restaurant.name,restaurant_path(@restaurant)
    add_breadcrumb 'New Review','#'
    @review = @restaurant.reviews.build
  end

  def edit
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.find(params[:id])
    add_breadcrumb @restaurant.name,restaurant_path(@restaurant)
    add_breadcrumb @review.id,restaurant_review_path(@restaurant,@review)
    add_breadcrumb 'Edit Review','#'
  end


  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.build(params[:review])
    if @review.save
      redirect_to([@restaurant,@review], notice: 'Review was successfully created.') 
    else
      render action: 'new'
    end
  end

  def update
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.find(params[:id])

    if @review.update_attributes(params[:review])
      redirect_to([@restaurant,@review], notice: 'Review was successfully updated.') 
    else
      render action: 'edit'
    end

  end

  def user_notes
    @reviews = current_user.reviews
    @breadcrumbs = []
    add_breadcrumb 'User Notes',users_notes_path
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    flash[:notice] = 'Successfully deleted the review.'
    redirect_to restaurant_path(@review.restaurant_id)
  end

  private
    def init_breadcrumb
      add_breadcrumb 'All Restaurants', restaurants_path
    end
end
