class Review < ActiveRecord::Base
  attr_accessible :author, :review_created_at, :created_at, :desc, :source, :title, :restaurant_id, :consolidated_notes, :digest

  belongs_to :restaurant
  has_many :feedbacks

  validates_uniqueness_of :digest, scope: :restaurant_id
  validates_presence_of :review_created_at

  #before_save :compute_consolidate_notes!
  before_validation :compute_digest!

  serialize :consolidated_notes, Hash

  def get_feedback user 
    feedbacks.where(:user_id => user.id).first
  end

  def get_notes(current_user)
    notes.where(:user_id => current_user.id)
  end

  def compute_consolidate_notes!
    self.consolidated_notes = compute_consolidated_notes
  end

  def compute_digest!
    self.digest = Digest::MD5.hexdigest(desc)
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

end
