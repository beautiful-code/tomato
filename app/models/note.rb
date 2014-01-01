class Note < ActiveRecord::Base
  belongs_to :review
  belongs_to :user
  attr_accessible :item, :rating, :review_id, :user_id

  validates_presence_of :user_id
  before_save :normalize_item!

  def normalize_item!
    self.item = normalized_item
  end

  def normalized_item
    item.split(" ").collect(&:downcase).collect(&:capitalize).join(' ')
  end
end
