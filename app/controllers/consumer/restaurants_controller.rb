class Consumer::RestaurantsController < ApplicationController

  before_filter :authenticate_user!

  layout 'restaurant_owner'

  def show
    @restaurant = Restaurant.find(params[:id])
    review_hash=@restaurant.reviews.where(:review_created_at => ((Time.now-1500.days)..(Time.now))).group("date(review_created_at)").count()
    @count_array = review_hash.to_a  #.unshift(['Date','Reviews'])
    @count_array.sort! { |a, b| a.second <=> b.second }.unshift(['Date','Reviews'])
  end

  def review_chart
    @restaurant = Restaurant.find(params[:id])
    if (as_params = params[:date])
      start_date = DateTime.new as_params['start_date(1i)'].to_i, as_params['start_date(2i)'].to_i, as_params['start_date(3i)'].to_i
      end_date = DateTime.new as_params['end_date(1i)'].to_i, as_params['end_date(2i)'].to_i, as_params['end_date(3i)'].to_i
    else
      start_date = Date.today - 1900.days
      end_date = Date.today
    end
    review_hash=@restaurant.reviews.where(:review_created_at =>(start_date..end_date)).group("date(review_created_at)").count()
    @count_array = review_hash.to_a
    @count_array.sort! { |a, b| a.first <=> b.first}.collect! {|e| [e.first.to_time.to_i,e.second]}
    render 'show'
  end

end
