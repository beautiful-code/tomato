class Review < ActiveRecord::Base
  attr_accessible :author, :review_created_at, :created_at, :desc, :source, :title, :restaurant_id, :consolidated_feedback, :digest

  belongs_to :restaurant
  has_many :feedbacks

  validates_uniqueness_of :digest, scope: :restaurant_id
  validates_presence_of :review_created_at

  before_validation :compute_digest!

  serialize :consolidated_feedback, Hash

  def next
    restaurant.reviews.where("id < ? AND source = ?", id, source).first
  end

  def prev
    restaurant.reviews.where("id > ? AND source = ?", id, source).last
  end

  def get_feedback user 
    feedbacks.where(:user_id => user.id).first
  end

  def compute_digest!
    self.digest = Digest::MD5.hexdigest(desc)
  end

  def self.compute_consolidated_feedback!
    Review.all.collect(&:compute_consolidated_feedback!)
  end

  def compute_consolidated_feedback!
    result = {}
    if feedbacks.present?
      notes_array = feedbacks.collect(&:notes_as_hash)
      merged_notes = notes_array.reduce({}) {|h,pairs| pairs.each {|k,v| (h[k] ||= []) << v}; h}

      merged_notes.reject! {|k,v| v.size != feedbacks.size}
      merged_notes.each do |k, v|
        merged_notes[k] = merged_notes[k].inject(:+)/merged_notes[k].size
      end
      result["dishes"] = merged_notes

      parameter_array = feedbacks.collect(&:parameter_as_hash)
      merged_parameter = parameter_array.reduce({}) {|h,pairs| pairs.each {|k,v| (h[k] ||= []) << v}; h}


      merged_parameter.reject! {|k,v| (v.size != feedbacks.size) || (v.uniq.size != 1)}
      merged_parameter.each do |k, v|
        merged_parameter[k] = merged_parameter[k].uniq.first
      end
      result["parameters"] = merged_parameter


      result["computed_at"] = Time.now
    end

    result
    self.consolidated_feedback = result
    self.save(:validate => false)
  end

  def consolidated_scores

    # Deep clone
    result = Marshal.load( Marshal.dump(consolidated_feedback) )

    if result.present?
      result["parameters"].each do |k,v|
        result["parameters"][k] = Parameter.score_for(k,v)
      end
    end

    result
  end

  def dish_scores
    consolidated_scores["dishes"] || {}
  end

  def parameters_scores
    consolidated_scores["parameters"] || {}
  end

  def category_scores cat
    cat_features = Parameter.send("#{cat}_features").keys
    (consolidated_scores["parameters"]||{}).slice(*cat_features)
  end

  def scorable_category_scores cat
    category_scores(cat).select {|k,v| v > 0}
  end

=begin
  # TODO: Remove category_score
  def category_score cat
    feature_weight = 1.to_f/Parameter.send("#{cat}_features").size
    scorable_category_scores(cat).values.multiply_by(feature_weight).inject(:+)
  end
=end

  def dish_score
    dish_scores.present? ? dish_scores.values.inject(:+).to_f/dish_scores.size : nil
  end

end

class Array
  def multiply_by(x)
    collect { |n| n * x }
  end
end
