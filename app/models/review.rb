class Review < ActiveRecord::Base
  attr_accessible :author, :created_at, :desc, :source, :title, :restaurant_id
  belongs_to :restaurant
  has_many :notes
  validates_uniqueness_of :desc, scope: :restaurant_id

  def get_notes(current_user)
    notes.where(:user_id => current_user.id)
  end

  # Consolidates all the users notes
  def consolidated_notes
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
