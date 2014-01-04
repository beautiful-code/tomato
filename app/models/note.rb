class Note < ActiveRecord::Base
  attr_accessible :item, :rating

  belongs_to :feedback

  before_save :normalize_item!

  def review
    feedback.review
  end

  def normalize_item!
    self.item = normalized_item
  end

  def normalized_item
    item.split(" ").collect(&:downcase).collect(&:capitalize).join(' ')
  end
end
