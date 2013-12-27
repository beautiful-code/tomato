class Note < ActiveRecord::Base
  belongs_to :review
  belongs_to :user
  attr_accessible :item, :rating, :review_id, :user_id

  validates_presence_of :user_id
end
