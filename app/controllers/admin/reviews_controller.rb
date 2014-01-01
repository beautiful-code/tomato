class Admin::ReviewsController < ApplicationController
  before_filter :set_admin
  before_filter :authenticate_user!
  before_filter :authenticate_admin!

  def show
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.find(params[:id])
    @users = @review.notes.select('distinct(user_id)').collect {|user_entry| User.find(user_entry.user_id) }
  end

  def zomato
    @restaurant = Restaurant.find(params[:restaurant_id])
    @reviews = @restaurant.reviews.where(source:'Zomato').order('review_created_at DESC')
    @reviews = Kaminari.paginate_array(@reviews).page(params[:page]).per(4)

    @source = 'zomato'
    render 'reviews/source_reviews'
  end

  def burrp
    @restaurant = Restaurant.find(params[:restaurant_id])
    @reviews = @restaurant.reviews.where(source:'Burrp').order('review_created_at DESC')
    @reviews = Kaminari.paginate_array(@reviews).page(params[:page]).per(4)

    @source = 'burrp'
    render 'reviews/source_reviews'
  end

  def yelp
    @restaurant = Restaurant.find(params[:restaurant_id])
    @reviews = @restaurant.reviews.where(source:'Yelp').order('review_created_at DESC')
    @reviews = Kaminari.paginate_array(@reviews).page(params[:page]).per(4)

    @source = 'yelp'
    render 'reviews/source_reviews'
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.build
  end

  def edit
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.find(params[:id])
  end


  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.build(params[:review])

    if @review.save
      redirect_to(admin_restaurant_review_path(@restaurant,@review), notice: 'Review was successfully created.')
    else
      render action: 'new'
    end
  end

  def update
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.find(params[:id])

    if @review.update_attributes(params[:review])
      redirect_to(admin_restaurant_review_path(@restaurant,@review), notice: 'Review was successfully updated.')
    else
      render action: 'edit'
    end

  end

  def reviews
    @reviews = current_user.reviews;
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    flash[:notice] = 'Successfully deleted the review.'
    redirect_to admin_restaurant_path(@review.restaurant_id)
  end


  private
    def authenticate_admin!
      redirect_to root_path, alert: "Admin area restricted !"  unless admin?
    end

    def admin?
      current_user.has_role? :admin
    end

end
