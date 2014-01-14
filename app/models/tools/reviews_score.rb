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

=begin
    def service_score
        sum = 0
        count = 0
        reviews.each do |review|
          sum = sum + review.scorable_category_scores("service").values.inject(:+)
          count = count + review.scorable_category_scores("service").size
        end

        (count > 0 ) ? sum/count : nil
    end
=end



  end

end
