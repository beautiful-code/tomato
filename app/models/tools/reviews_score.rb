module Tools

  class ReviewsScore
    attr_accessor :reviews

    def initialize reviews
      @reviews = reviews
    end

    def overall_score
    end

    def category_score category
      sum = 0
      count = 0
      reviews.each do |review|
        sum += review.scorable_category_scores(category).values.inject(:+).to_i
        count += review.scorable_category_scores(category).size
      end

      (count > 0 ) ? sum.to_f/count : nil
    end


    def feature_score feature
        sum = 0
        count = 0
        reviews.each do |review|
          if review.parameters_scores[feature]
            sum += review.parameters_scores[feature]
            count += 1
          end
        end

      (count > 0 ) ? sum.to_f/count : nil
    end

    # Overall dish score
    def dish_score
      dish_scores = reviews.collect{|e| e.dish_score}.compact
      dish_scores.present? ? dish_scores.inject(:+)/dish_scores.size : nil
    end


    def category_features_scores category
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

    def time_vs_category_rating category
      result = {}
      reviews.each do |review|
        (result[review.review_created_at.to_date] ||= []) << review
      end

      result.each do |day, daily_reviews|
        dr = Tools::ReviewsScore.new(daily_reviews)
        result[day] = dr.category_score category

      end


      # Remove days with nil score
      result.delete_if {|k,v| !v.present?}

      result
    end

    #returns required rating hashes
    def category_rating_hashes categories
      categories.collect!{|category| {category=> time_vs_category_rating(category)}}.inject(:merge)
    end

    #returns required feature rating hashes
    def feature_rating_hashes features
      features.collect!{|feature| {feature=> time_vs_feature_rating(feature)}}.inject(:merge)
    end



    def time_vs_feature_rating feature
      result = {}
      reviews.each do |review|
        (result[review.review_created_at.to_date] ||= []) << review
      end

      result.each do |day, daily_reviews|
        dr = Tools::ReviewsScore.new(daily_reviews)
        result[day] = dr.feature_score feature
      end

      # Remove days with nil score
      result.delete_if {|k,v| !v.present?}

      result
    end

  end

end
