class Feedback < ActiveRecord::Base
  attr_accessible :review_id, :user_id

  belongs_to :review
  belongs_to :user

  has_many :notes, :dependent => :destroy
  has_one :parameter, :dependent => :destroy

  validates_presence_of :user_id
  validates_presence_of :review_id

  def notes_as_hash
    result = {}
    notes.each { |note| result[note.item] = note.rating }
    result
  end

  def parameter_as_hash
    parameter.content
  end
end
