module Tools

  class ReviewsScore
    attr_accessor :reviews

    def initialize reviews
      @reviews = reviews
    end

    def overall_score
    end

    Parameter::CATEGORIES.each do |category|
      define_method "#{category}_score" do
        sum = 0
        count = 0
        reviews.each do |review|
          sum += review.scorable_category_scores(category).values.inject(:+).to_i
          count += review.scorable_category_scores(category).size
        end

        (count > 0 ) ? sum/count : nil
      end
    end

    def dish_score
      sum = 0
      count = 0

      reviews.each do |review|
        review.dish_scores.each do |k, v|
          count +=1
          sum += v
        end
      end

      (count > 0 ) ? sum/count : nil
    end

  end

end
