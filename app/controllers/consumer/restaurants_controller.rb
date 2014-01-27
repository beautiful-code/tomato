class Consumer::RestaurantsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :load_restaurant
  before_filter :load_reviews
  before_filter :load_dish, only: [:dish_chart]

  layout 'consumer'

  def overview
    review_hash=@reviews.group("date(review_created_at)").count()
    @count_array = review_hash.to_a
    @count_array.sort! { |a, b| a.first <=> b.first }.collect! { |e| [e.first.to_time.to_i, e.second] }
    ob = Tools::ReviewsScore.new(@reviews)
    @trending_dishes = ob.trending_dishes
  end

  def category_chart

  end

  def restaurant
    ob = Tools::ReviewsScore.new(@reviews)
    @category = 'restaurant'
  end

  def features
    ob = Tools::ReviewsScore.new(@reviews)
    category = cookies['category']
    category_rating_hash = ob.category_rating_hashes([category])
    feature_rating_hashes_orig = ob.feature_rating_hashes(chart_parameters) if chart_parameters
    feature_rating_hashes_orig ? (rating_hashes_orig = category_rating_hash.merge feature_rating_hashes_orig) : rating_hashes_orig = category_rating_hash
    #Get date points from all features for use as keys
    keys = []
    rating_hashes_orig.values.each{|hash| keys.push hash.keys  }        #.inject {|union,hash| hash.keys | union.keys}
    keys.flatten!().uniq!
    if keys
      @rating_hash = {}
      (keys).each {|key,value| @rating_hash[key]=  rating_hashes_orig.values.collect{|hash| hash[key] } }
      #(keys).each {|key| @feature_rating_hash[key]= @parking_rating_hash[key],@ambience_rating_hash[key]}
      @rating = @rating_hash.to_a.collect{|r|  r[1].unshift(r[0].to_time.to_i)}
      @rating.sort! { |a, b| a.first <=> b.first }
      render json: {'columns'=>chart_parameters.push(category).collect(&:humanize),'rows'=> @rating}
    end
  end

  def service
    ob = Tools::ReviewsScore.new(@reviews)
    @category = 'service'
    render 'restaurant'
  end



  def dishes
    ob = Tools::ReviewsScore.new(@reviews)
    @dishes = ob.all_dishes
    cookies['dish']='South'
  end

  #Endpoint for returning chart data for a specific dish
  def dish_chart
    ob = Tools::ReviewsScore.new(@reviews)
    rating_hash = ob.time_vs_dish_rating @dish
    @rating = rating_hash.to_a.collect{|r|  [r[0].to_time.to_i,r[1]]}
    render json: {'columns'=>[@dish],'rows'=>@rating}
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
    if (cookies['start_day'].present?)
      @start_date = Date.new cookies['start_year'].to_i, cookies['start_month'].to_i, cookies['start_day'].to_i
      @end_date = Date.new cookies['end_year'].to_i, cookies['end_month'].to_i, cookies['end_day'].to_i
    else
      @start_date = Date.today - 1000.days
      @end_date = Date.today
    end
  end

  def chart_parameters
  #TODO Memoize this shit
    if cookies['chart_parameters']
      @chart_parameters = cookies['chart_parameters'].split(',')
    else
      []
    end
  end

  def load_dish
    @dish = cookies['dish']
  end



end


