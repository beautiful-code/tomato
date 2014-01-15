module Tools

=begin
  ob = ReviewsScore.new(Review.all)
  ob = ReviewsScore.new([Review.find(2)])
  ob.restaurant_score
  ob.service_score
  ob.food_score
  ob.time_vs_rating(category)
=end


  class ReviewsScore
    attr_accessor :reviews

    def initialize reviews
      @reviews = reviews
    end

    def overall_score
    end

=begin
    Parameter::CATEGORIES.each do |category|
      define_method "#{category}_score" do
        sum = 0
        count = 0
        reviews.each do |review|
          sum += review.scorable_category_scores(category).values.inject(:+).to_i
          count += review.scorable_category_scores(category).size
        end

        (count > 0 ) ? sum.to_f/count : nil
      end
    end
=end

    Parameter::CATEGORIES.each do |category|
      define_method "#{category}_score" do
        category_scores = reviews.collect{|e| e.category_score(category)}.compact
        category_scores.present? ? category_scores.inject(:+)/category_scores.size : nil
      end
    end



    # Overall dish score
    def dish_score
      dish_scores = reviews.collect{|e| e.dish_score}.compact
      dish_scores.present? ? dish_scores.inject(:+)/dish_scores.size : nil
    end

=begin
    # Returns a hash of all restaurant_specific feature scores
    def restaurant_features_scores
      result = {}
      all_restaurant_features = ::Parameter.restaurant_features.keys
      reviews.each do |review|
        interested_features_scores = review.parameters_scores.slice(*all_restaurant_features)

        interested_features_scores.each do |k,v|
          (result[k] ||= []) << v
        end
      end

      result.each {|k,v| result[k] = v.inject(:+).to_f/v.size}

      result
    end
=end

    Parameter::CATEGORIES.each do |category|
      define_method "#{category}_features_scores" do
        result = {}

        reviews.each do |review|
          interested_features_scores = review.scorable_category_scores(category)

          interested_features_scores.each do |k,v|
            (result[k] ||= []) << v
          end
        end

      result.each {|k,v| result[k] = v.inject(:+).to_f/v.size}
      result
      end

    end

    # TODO: Dont use category_score on a review. Use category_scores on the set of daily reviews.
    def time_vs_category_rating category
      result = {}
      reviews.each do |review|
        (result[review.review_created_at.to_date] ||= []) << review.category_score(category) if review.category_score(category)
      end

      puts result.inspect
      result.each {|k,v| result[k] = v.inject(:+).to_f/v.size}
      result
    end

    def time_vs_feature_rating feature
      # Use parameter_scores
    end

  end

end
