class ReviewsController < ApplicationController

  def show
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.find(params[:id])
  end

  def zomato
    @restaurant = Restaurant.find(params[:restaurant_id])
    @reviews = @restaurant.reviews.find_all_by_source('Zomato')
    @reviews.sort_by! {|review| review.review_created_at }
    @reviews = Kaminari.paginate_array(@reviews).page(params[:page]).per(4)
  end

  def burrp
    @restaurant = Restaurant.find(params[:restaurant_id])
    @reviews = @restaurant.reviews.find_all_by_source('Burrp')
    @reviews.sort_by! {|review| review.review_created_at }
    @reviews = Kaminari.paginate_array(@reviews).page(params[:page]).per(4)
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
      redirect_to([@restaurant,@review], notice: 'Review was successfully created.') 
    else
      render action: "new"
    end
  end

  def update
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.find(params[:id])

    if @review.update_attributes(params[:review])
      redirect_to([@restaurant,@review], notice: 'Review was successfully updated.') 
    else
      render action: "edit" 
    end

  end


  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    flash[:notice] = "Successfully deleted the review."
    redirect_to restaurant_path(@review.restaurant_id)
  end
end
