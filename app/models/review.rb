class Review < ActiveRecord::Base
  attr_accessible :author, :created_at, :desc, :source, :title, :restaurant_id
  belongs_to :restaurant
  has_many :notes
  validates_uniqueness_of :desc, scope: :restaurant_id 
end
