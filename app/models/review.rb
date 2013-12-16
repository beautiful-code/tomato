class Review < ActiveRecord::Base
  attr_accessible :author, :created_at, :desc, :source, :title, :restaurant_id
  belongs_to :restaurant
end
