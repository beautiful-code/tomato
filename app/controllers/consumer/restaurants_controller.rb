class Consumer::RestaurantsController < ApplicationController

  before_filter :authenticate_user!

  before_filter :load_restaurant
  before_filter :load_reviews

  layout 'restaurant_owner'

  def overview
    review_hash=@reviews.group("date(review_created_at)").count()
    @count_array = review_hash.to_a
    @count_array.sort! { |a, b| a.first <=> b.first }.collect! { |e| [e.first.to_time.to_i, e.second] }
  end

  def restaurant
    ob = Tools::ReviewsScore.new(@reviews)
    orig_rating_hashes = ob.category_rating_hashes(['restaurant','service'])
    @restaurant_rating_hash,@service_rating_hash = orig_rating_hashes['restaurant'],orig_rating_hashes['service']
    keys = @restaurant_rating_hash.keys | @service_rating_hash.keys
    @rating_hash = {}
    (keys).each {|key| @rating_hash[key]= @restaurant_rating_hash[key],@service_rating_hash[key]}
    @rating = @rating_hash.to_a.collect{|r| [r[0],r[1][0],r[1][1]]}
    @rating.sort! { |a, b| a.first <=> b.first }.collect! { |e| [e[0].to_time.to_i, e[1],e[2]] }
  end

  def restaurant_features
    ob = Tools::ReviewsScore.new(@reviews)
    feature_rating_hashes_orig = ob.feature_rating_hashes(chart_parameters)
    #Get date points from all features for use as keys
    keys = []
     feature_rating_hashes_orig.values.each{|hash| keys.push hash.keys  }        #.inject {|union,hash| hash.keys | union.keys}
    keys.flatten!().uniq!
    #keys = @parking_rating_hash.try(:keys) | @ambience_rating_hash.try(:keys)
    if keys
      @feature_rating_hash = {}
      (keys).each {|key,value| @feature_rating_hash[key]=  feature_rating_hashes_orig.values.collect{|hash| hash[key] } }
      #(keys).each {|key| @feature_rating_hash[key]= @parking_rating_hash[key],@ambience_rating_hash[key]}
      @feature_rating = @feature_rating_hash.to_a.collect{|r|  r[1].unshift(r[0].to_time.to_i)}
      @feature_rating.sort! { |a, b| a.first <=> b.first }
      render json: {'columns'=>chart_parameters,'rows'=> @feature_rating}
      #render 'restaurant'
    end
  end

  def service
  end


  private
  def load_reviews
    load_restaurant
    load_start_and_end_dates

    @reviews = @restaurant.reviews.where(:review_created_at => (@start_date..@end_date))
    @reviews_score = Tools::ReviewsScore.new(@reviews)
  end

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

  def chart_parameters
  #TODO Memoize this shit
   @chart_parameters = cookies['chart_parameters'].split(',')
  end



end


