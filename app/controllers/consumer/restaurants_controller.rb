class Consumer::RestaurantsController < ApplicationController

  before_filter :authenticate_user!

  before_filter :load_restaurant

  layout 'restaurant_owner'

  def overview 
    load_start_and_end_dates

    @reviews = @restaurant.reviews.where(:review_created_at =>(@start_date..@end_date))
    review_hash=@reviews.group("date(review_created_at)").count()

    @reviews_score = Tools::ReviewsScore.new(@reviews)


    @count_array = review_hash.to_a
    @count_array.sort! { |a, b| a.first <=> b.first}.collect! {|e| [e.first.to_time.to_i,e.second]}
  end


  private
  def load_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def load_start_and_end_dates
    # Cookies were set on the browser.
    if (cookies['start_day'])
      @start_date = Date.new cookies['start_year'].to_i, cookies['start_month'].to_i, cookies['start_day'].to_i
      @end_date = Date.new cookies['end_year'].to_i, cookies['end_month'].to_i, cookies['end_day'].to_i
    else
      @start_date = Date.today - 1000.days
      @end_date = Date.today
    end
  end

end
