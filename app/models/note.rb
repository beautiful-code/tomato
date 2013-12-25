class Note < ActiveRecord::Base
  belongs_to :review
  attr_accessible :item, :rating, :review_id
end
