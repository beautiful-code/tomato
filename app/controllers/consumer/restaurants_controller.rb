class Consumer::RestaurantsController < ApplicationController

  before_filter :authenticate_user!

  before_filter :load_restaurant

  layout 'restaurant_owner'

  def overview 
    load_start_and_end_dates

    review_hash=@restaurant.reviews.where(:review_created_at =>(@start_date..@end_date)).group("date(review_created_at)").count()

    @count_array = review_hash.to_a
    @count_array.sort! { |a, b| a.first <=> b.first}.collect! {|e| [e.first.to_time.to_i,e.second]}
  end


  private
  def load_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def load_start_and_end_dates
    if (as_params = params[:date])
      @start_date = DateTime.new as_params['start_date(1i)'].to_i, as_params['start_date(2i)'].to_i, as_params['start_date(3i)'].to_i
      @end_date = DateTime.new as_params['end_date(1i)'].to_i, as_params['end_date(2i)'].to_i, as_params['end_date(3i)'].to_i
    else
      @start_date = Date.today - 1000.days
      @end_date = Date.today
    end
  end

end
