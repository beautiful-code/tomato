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
    result = consolidated_feedback
    if result.present?
      
      
    end

    result
  end

=begin
  def get_notes(current_user)
    notes.where(:user_id => current_user.id)
  end

  def compute_consolidate_notes!
    self.consolidated_notes = compute_consolidated_notes
  end


  # Consolidates all the users notes
  def compute_consolidated_notes
    ret = {}

    notes.each do |note|
      ret[note.item] ||=[]
      ret[note.item] << note.rating
    end

    ret.each do |k, v|
      ret[k] = v.inject(:+)/v.size
    end
    
    ret
  end
=end

end
